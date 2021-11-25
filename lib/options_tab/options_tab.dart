import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';

class opt_tab extends StatelessWidget {
  const opt_tab({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " Name ",
      home: userNameScreen(),
    );
  }
}

class userNameScreen extends StatefulWidget {
  const userNameScreen({Key? key}) : super(key: key);

  @override
  userNameScreenState createState() => userNameScreenState();
}

// ignore: camel_case_types
class userNameScreenState extends State<userNameScreen> {
  bool _theme = true;
  Color coloreBackGround = Colors.white;
  Color coloreScritte = Colors.black;
  Color coloreBackGroundButton = Colors.black;
  Color coloreScritteButton = Colors.white;
  Color coloreIcons = Colors.black;
  Color coloreScritteIcons = Colors.black;

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: coloreBackGround,
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Column(children: [
          Container(
            child: Column(
              children: [
                imageProfile(),
                // ignore: prefer_const_constructors
                Center(
                  child: Text(
                    "Username",
                    style: TextStyle(
                        color: coloreScritte, height: 3, fontSize: 35),
                  ),
                ),
                Center(
                  child: SwitchListTile(
                    title: Text(
                      "Force Light Mode",
                      style: TextStyle(color: coloreScritte),
                    ),
                    value: _theme,
                    onChanged: (bool value) {
                      setState(
                        () {
                          if (_theme == true) {
                            coloreBackGround = Colors.black;
                            coloreScritte = Colors.blue;
                            coloreBackGroundButton = Colors.white;
                            coloreScritteButton = Colors.black;
                            _theme = false;
                          } else {
                            _theme = true;
                            coloreBackGround = Colors.white;
                            coloreScritte = Colors.black;
                            coloreBackGroundButton = Colors.black;
                            coloreScritteButton = Colors.white;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //BackGround
                  primary: coloreBackGroundButton,
                  //Scritte bottone
                  onPrimary: coloreScritteButton,
                ),
                onPressed: () {},
                child: const Text(
                  "Disconnect",
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget imageProfile() {
  return Center(
    child: Stack(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.grey,
          backgroundImage: null,
        ),
      ],
    ),
  );
}
