import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:maki/models/anime_list.dart';

import 'anime.dart';
import 'event.dart';

const _access_token_key = "access_token";

// TODO: remove hentai from fetched lists :3
// cultured things may not be the best to show
const _query_get_anime_list = """
query (\$userId: Int, \$userName: String, \$type: MediaType) {
  MediaListCollection(userId: \$userId, userName: \$userName, type: \$type) {
    lists {
      name
      entries {
        ...mediaListEntry
      }
    }
    user {
      mediaListOptions {
        scoreFormat
      }
    }
  }
}

fragment mediaListEntry on MediaList {
  mediaId
  status
  score
  media {
    title {
      userPreferred
    }
    coverImage {
      large
    }
    isAdult
  }
}
""";

const _query_get_logged_user = """
query {
    user: Viewer {
      name
      id
      avatar {
        large
      }
    }
  }
""";

const _query_add_anime_to_list = """
mutation (\$mediaId: Int, \$status: MediaListStatus) {
  SaveMediaListEntry (mediaId: \$mediaId, status: \$status) {
    id
    status
   }
}
""";

const _query_remove_anime_from_list = """
mutation (\$mediaId: Int) {
  DeleteMediaListEntry (id: \$mediaId) {
  deleted
  }
}
""";

enum AnimeSublist { completed, watching, planning, dropped }

class User {
  // current user logged in, may be null
  static User? current;

  final String username;
  final String profilePicture;
  final String token;

  AnimeList? _animeList;

  SimpleEvent onAnimeListUpdate = SimpleEvent();

  User(
      {required this.username,
      required this.profilePicture,
      required this.token});

  /// call this function to retrive the user list
  /// if possibile this function returns a cached version
  /// but is possibile to force the fetch by setting forceUpdate to true
  Future<AnimeList> getAnimeList({bool forceUpdate = false}) async {
    if (_animeList != null && !forceUpdate) {
      return Future.value(_animeList);
    }

    var apiRes = await _authenticatedAnilistRequest(
        token, _query_get_anime_list,
        variables: jsonEncode({"userName": username, "type": "ANIME"}));

    _animeList = AnimeList.fromAnilist(apiRes!);

    return Future.value(_animeList);
  }

  Future<List<Anime>> getAnimeSublist(AnimeSublist sublist) async {
    var list = await getAnimeList();

    switch (sublist) {
      case AnimeSublist.completed:
        return list.completed;

      case AnimeSublist.watching:
        return list.watching;

      case AnimeSublist.dropped:
        return list.dropped;

      case AnimeSublist.planning:
        return list.planning;
    }
  }

  /// add anime to the user planning list
  /// if something went wrong this functions returns false
  Future<bool> addToPlanning(Anime anime) async {
    var res = await _authenticatedAnilistRequest(
        token, _query_add_anime_to_list,
        variables:
            jsonEncode({"mediaId": anime.anilistID, "status": "PLANNING"}));

    if (res == null) {
      return Future.value(false);
    }

    // refetch list to update
    getAnimeList(forceUpdate: true);

    // send callback
    onAnimeListUpdate.call();

    return Future.value(true);
  }

  /// remove anime to the user planning list
  /// if something went wrong this functions returns false
  Future<bool> removeFromList(Anime anime) async {
    var res = await _authenticatedAnilistRequest(
        token, _query_remove_anime_from_list,
        variables: jsonEncode({"mediaId": anime.anilistID}));

    if (res == null) {
      return Future.value(false);
    }

    // refetch list to update
    getAnimeList(forceUpdate: true);

    // send callback
    onAnimeListUpdate.call();

    return Future.value(true);
  }

  bool _hasAnimeInSublist(List<Anime> sublist, Anime anime) {
    for (var item in sublist) {
      if (item.anilistID == anime.anilistID) {
        return true;
      }
    }

    return false;
  }

  /// check if the user has an anime in its list
  bool hasAnimeInList(Anime anime) {
    return _animeList != null &&
        (_hasAnimeInSublist(_animeList!.watching, anime) ||
            _hasAnimeInSublist(_animeList!.completed, anime) ||
            _hasAnimeInSublist(_animeList!.planning, anime) ||
            _hasAnimeInSublist(_animeList!.dropped, anime));
  }

  //***********************************************************************************

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// loging the user by using the token stored on the device
  /// if no token is available this function retuns false
  /// and web_login should be called instead
  ///
  /// if this functions returns true then current uses is not null
  static Future<bool> login() async {
    var token = await _storage.read(key: _access_token_key);

    if (token != null) {
      try {
        current = await User.fromToken(token);
        // prefetch anime list
        current!.getAnimeList();
        return Future.value(true);
      } catch (e) {
        // login failed
        debugPrint(e.toString());
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  /// login the user on anilist by opening a web browser page
  /// and request the user to log on their anilist account
  ///
  /// if this functions returns true then current uses is not null
  static Future<bool> web_login() async {
    try {
      final result = await FlutterWebAuth.authenticate(
          url:
              "https://anilist.co/api/v2/oauth/authorize?client_id=6965&response_type=token",
          callbackUrlScheme: "xyz.makichan.app");

      RegExp tokenRegex = RegExp(r"#access_token=(.+)&token_type");
      var matches = tokenRegex.allMatches(result);

      final token = matches.elementAt(0).group(1);

      await _storage.write(key: _access_token_key, value: token);
      return await login();
    } catch (e) {
      debugPrint(e.toString());
      //rethrow;
    }

    return Future.value(false);
  }

  /// logout the current user and clear saved tokens
  /// if no current user this function does nothing
  static void logout() {
    debugPrint("Loggin out");
    current = null;
    _storage.delete(key: _access_token_key);
  }

  ///fetch user information using the token obtained from oauth
  static Future<User> fromToken(String token) async {
    var resp =
        await _authenticatedAnilistRequest(token, _query_get_logged_user);

    if (resp == null) {
      throw Exception("Unable to login");
    }

    resp = resp["data"]!["user"];
    return User(
        username: resp!["name"],
        profilePicture: resp["avatar"]["large"],
        token: token);
  }

  /// Do a post request to anilist api with the user token
  static Future<Map<String, dynamic>?> _authenticatedAnilistRequest(
      String token, String query,
      {String? variables}) async {
    var body = {
      "query": query,
    };

    if (variables != null) {
      body["variables"] = variables;
    }

    final response = await http.post(Uri.parse('https://graphql.anilist.co/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token,
          'Accept': 'application/json',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.toString());
      return null;
    }
  }
}
