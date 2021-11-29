import 'package:flutter/material.dart';
import 'package:maki/login_page/login_page.dart';
import 'package:maki/models/user.dart';

class OptionsTabPage extends StatefulWidget {
  String nome;
  String? profilePicture;

  OptionsTabPage({Key? key, required this.nome, this.profilePicture}) : super(key: key);

  @override
  State<OptionsTabPage> createState() => _OptionsTabPageState();
}

class _OptionsTabPageState extends State<OptionsTabPage> {


  Text buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 28),
    );
  }

  Widget imageProfile(String? imgUrl) {
    return Center(
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.grey,
            foregroundImage: imgUrl != null ? Image.network(imgUrl).image : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(children: [
          Column(
            children: [
              imageProfile(widget.profilePicture),
              // ignore: prefer_const_constructors
              Center(
                child: Text(
                  widget.nome,
                  style:
                      const TextStyle(color: Colors.black, height: 3, fontSize: 35),
                ),
              ),
              Center(
                child: SwitchListTile(
                  title: const Text(
                    "Force Dark Mode",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: false,
                  onChanged: (bool value) {
                    setState(
                      () {},
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 220),
                child: SizedBox(
                  width: 370.0,
                  height: 60.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //BackGround
                      primary: Colors.red,
                      //Scritte bottone
                      onPrimary: Colors.white,
                    ),
                    onPressed: () { User.logout(); LoginPage.refreshLogin(context); },
                    child: buildText(
                      "Disconnect",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


