import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';

class OptionsTabPage extends StatefulWidget {
  String nome;
  OptionsTabPage({Key? key, required this.nome}) : super(key: key);

  @override
  State<OptionsTabPage> createState() => _OptionsTabPageState();
}

class _OptionsTabPageState extends State<OptionsTabPage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(children: [
          Container(
            child: Column(
              children: [
                imageProfile(),
                // ignore: prefer_const_constructors
                Center(
                  child: Text(
                    widget.nome,
                    style:
                        TextStyle(color: Colors.black, height: 3, fontSize: 35),
                  ),
                ),
                Center(
                  child: SwitchListTile(
                    title: Text(
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
                    onPressed: () {},
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

Text buildText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 28),
  );
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
