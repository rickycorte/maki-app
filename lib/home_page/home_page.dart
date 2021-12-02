import 'package:flutter/material.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/common/future_anime_cover_grid.dart';
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
  Widget? _cachedRecommendationWidget;
  late Color colorTextTabBar = Colors.white;


  _HomePageState() {
      User.current?.onAnimeListUpdate.add(refreshUserList);
      debugPrint("Added user list refresh callback");
  }

  Future<bool> refreshGridBar() async {
    _cachedRecommendationWidget = null;
    setState(() {});

    return await Future.value(true);
  }

  void refreshUserList() {
    setState(() {});
  }

  Widget _futureRecommendationGrid(username) {
    _cachedRecommendationWidget ??= FutureBuilder<List<Anime>>(
        future: fetchRecommendations(username),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: refreshGridBar,
              child: AnimeCoverGrid(displayData: snapshot.data ?? []),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });

    return _cachedRecommendationWidget as Widget;
  }

  Widget _userList() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.red,
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    child: Align(
                      child: Text("Watching",
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Text("Completed",
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Text("Planning",
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child:
                      Text("Dropped", style:TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FutureAnimeCoverGrid(futureList: User.current!.getAnimeSublist(AnimeSublist.watching)),
            FutureAnimeCoverGrid(futureList: User.current!.getAnimeSublist(AnimeSublist.completed)),
            FutureAnimeCoverGrid(futureList: User.current!.getAnimeSublist(AnimeSublist.planning)),
            FutureAnimeCoverGrid(futureList: User.current!.getAnimeSublist(AnimeSublist.dropped)),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedTab() {
    switch (_selectedPageIndex) {
      case 1:
        return _userList();
      case 2:
        return OptionsTabPage(nome: User.current?.username ?? 'Test User', profilePicture: User.current?.profilePicture,);
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
        body: _getSelectedTab(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "For You"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "My List"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Options"),
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