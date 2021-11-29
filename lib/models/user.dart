
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

const _access_token_key = "access_token";

class User {

  // current user logged in, may be null
  static User? current;

  final String username;
  final String profilePicture;
  final String token;


  User({required this.username, required this.profilePicture, required this.token});



  //***********************************************************************************

  static const FlutterSecureStorage _storage = FlutterSecureStorage();


  /// loging the user by using the token stored on the device
  /// if no token is available this function retuns false
  /// and web_login should be called instead
  ///
  /// if this functions returns true then current uses is not null
  static Future<bool> login() async {
    var token = await _storage.read(key: _access_token_key);

    if(token != null)
    {
        current = await User.fromToken(token);
        return Future.value(true);
    }
    else {
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
          url: "https://anilist.co/api/v2/oauth/authorize?client_id=6965&response_type=token",
          callbackUrlScheme: "xyz.makichan.app"
      );

      RegExp tokenRegex = RegExp(r"#access_token=(.+)&token_type");
      var matches = tokenRegex.allMatches(result);

      final token = matches.elementAt(0).group(1);

      await _storage.write(key: _access_token_key, value: token);
      return await login();

    } catch(e) {
      debugPrint(e.toString());
      //rethrow;
    }

    return Future.value(false);
  }

  /// logout the current user and clear saved tokens
  /// if no current user this function does nothing
  static void logout() {

    current = null;
    _storage.delete(key: _access_token_key);
  }

  ///fetch user information using the token obtained from oauth
  static Future<User> fromToken(String token) async {

    const query = """
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


    var resp = await _authenticatedAnilistRequest(token, query);

    if(resp == null) {
      throw Exception("Unable to login");
    }

    resp = resp["data"]!["user"];
    return User(username: resp!["name"], profilePicture: resp["avatar"]["large"], token: token);

  }


  /// Do a post request to anilist api with the user token
  static Future<Map<String, dynamic>?> _authenticatedAnilistRequest(String token, String query, {String? variables}) async {

    var body = {
      "query": query,
    };

    if(variables != null) {
      body["variables"] = variables;
    }

    final response = await http.post(
        Uri.parse('https://graphql.anilist.co/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token,
          'Accept': 'application/json',
        },
        body:  jsonEncode(body)
    );

    if (response.statusCode == 200) {

      return jsonDecode(response.body);

    } else {
      debugPrint(response.toString());
      return null;
    }
  }

}