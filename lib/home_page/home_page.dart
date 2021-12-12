import 'package:flutter/material.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/common/future_anime_cover_grid.dart';
import 'package:maki/common/my_icons.dart';
import 'package:maki/details_page/elevated_rounded.dart';
import 'package:maki/models/anime.dart';
import 'package:maki/models/user.dart';
import 'package:maki/profile_page/option_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  Future<List<Anime>>? _cachedRecommendations;

  late Color colorTextTabBar = Colors.white;

  _HomePageState() {
    User.current?.onAnimeListUpdate.add(refreshUserList);
    debugPrint("Added user list refresh callback");
  }

  Future<bool> refreshGridBar() async {
    _cachedRecommendations = null;
    setState(() {});

    return await Future.value(true);
  }

  void refreshUserList() {
    setState(() {});
  }

  int getResponsiveGridItemCount() {
    var w = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    if (w > 1100) {
      return 4;
    }
    return 2;
  }

  Widget _futureRecommendationGrid(username) {
    _cachedRecommendations ??= fetchRecommendations(username);

    return FutureAnimeCoverGrid(
      futureList: _cachedRecommendations as Future<List<Anime>>,
      onRefreshCallback: refreshGridBar,
      elementsPerRow: getResponsiveGridItemCount(),
    );
  }

  Widget _userList(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
              child: ElevatedRounded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(25)), // clip animations
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.bodyText1!.color ??
                            Colors.black,
                    indicator: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.red,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(
                        child: Align(
                          child:
                              Text("Watching", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          child:
                              Text("Complete", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          child:
                              Text("Planning", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child:
                              Text("Dropped", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FutureAnimeCoverGrid(
              futureList: User.current!.getAnimeSublist(AnimeSublist.watching),
              elementsPerRow: getResponsiveGridItemCount(),
            ),
            FutureAnimeCoverGrid(
              futureList: User.current!.getAnimeSublist(AnimeSublist.completed),
              elementsPerRow: getResponsiveGridItemCount(),
            ),
            FutureAnimeCoverGrid(
              futureList: User.current!.getAnimeSublist(AnimeSublist.planning),
              elementsPerRow: getResponsiveGridItemCount(),
            ),
            FutureAnimeCoverGrid(
              futureList: User.current!.getAnimeSublist(AnimeSublist.dropped),
              elementsPerRow: getResponsiveGridItemCount(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedTab(BuildContext context) {
    switch (_selectedPageIndex) {
      case 1:
        return _userList(context);
      case 2:
        return OptionsTabPage(
          nome: User.current?.username ?? 'Test User',
          profilePicture: User.current?.profilePicture,
        );
      default:
        return _futureRecommendationGrid(User.current?.username ?? 'xDevily');
    }
  }

  void _onNavigationTabChange(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },
      child: Scaffold(
        //appBar: const CustomAppBar(),
        body: _getSelectedTab(context),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(MyIcons.favourite_Icon), label: "For you"),
            BottomNavigationBarItem(
                icon: Icon(MyIcons.viewList_Icon), label: "My list"),
            BottomNavigationBarItem(
                icon: Icon(MyIcons.settings_Icon), label: "Options"),
          ],
          onTap: _onNavigationTabChange,
          currentIndex: _selectedPageIndex,
        ),
      ),
    );
  }

  @override
  void dispose() {
    User.current?.onAnimeListUpdate.remove(refreshUserList);
    super.dispose();
  }
}
