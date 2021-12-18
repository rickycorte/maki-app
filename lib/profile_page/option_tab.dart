import 'package:flutter/material.dart';
import 'package:maki/details_page/elevated_rounded.dart';
import 'package:maki/login_page/login_page.dart';
import 'package:maki/models/user.dart';
import 'package:maki/profile_page/theme_changer.dart';
import 'package:provider/provider.dart';

class OptionsTabPage extends StatefulWidget {
  String nome;
  String? profilePicture;

  OptionsTabPage({Key? key, required this.nome, this.profilePicture})
      : super(key: key);

  @override
  State<OptionsTabPage> createState() => _OptionsTabPageState();
}

class _OptionsTabPageState extends State<OptionsTabPage> {

  bool forceDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadThemeSwitchVal();
  }

  void loadThemeSwitchVal() async {
    forceDarkMode = await ThemeChanger.shouldForceDarkTheme();
    setState(() {});
  }

  Text buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 28),
    );
  }

  Widget imageProfile(String? imgUrl) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.grey,
            foregroundImage:
                imgUrl != null ? Image.network(imgUrl).image : null,
          ),
        ],
      ),
    );
  }

  Widget _profileBaseInfo(context) {
    return ElevatedRounded(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(children: [
        imageProfile(widget.profilePicture),
        Center(
          child: Text(
            widget.nome,
            style:
                const TextStyle(height: 2, fontSize: 35),
          ),
        ),
        Text("Logged in with Anilist",
            style: Theme.of(context).textTheme.subtitle2),
        const SizedBox(height: 20),
        SizedBox(
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              User.logout();
              LoginPage.refreshLogin(context);
            },
            child: const Text("Logout"),
          ),
        ),
      ]),
    ));
  }


  Widget _settings(context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

    return ElevatedRounded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Settings", style: Theme.of(context).textTheme.headline5),
            SwitchListTile(
              title: Text(
                "Always use Dark Theme",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              value: forceDarkMode,
              onChanged: (bool current) async {
                themeChanger.setDarkTheme(current);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ListView (
              primary: false,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _profileBaseInfo(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _settings(context),
                ),
                const SizedBox(height: 5,)
              ]
            ),
        );
  }
}
