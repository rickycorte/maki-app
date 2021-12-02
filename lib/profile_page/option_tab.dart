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

  Widget _profileAndSettings(BuildContext context) {
   return  Column(
     children: [
       imageProfile(widget.profilePicture),
       // ignore: prefer_const_constructors
       Center(
         child: Text(
           widget.nome,
           style:
           const TextStyle(color: Colors.black, height: 2, fontSize: 35),
         ),
       ),
       Center(
         child: SwitchListTile(
           title: const Text(
             "Force Dark Mode",
             style: TextStyle(color: Colors.black),
           ),
           value: false,
           onChanged: (bool value) { setState(() {},);
           },
         ),
       ),
     ],
   );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0, bottom: 10.0),
          child: _profileAndSettings(context),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          left: 20,
          child: SizedBox(
            height: 60.0,
            child: ElevatedButton(
              onPressed: () { User.logout(); LoginPage.refreshLogin(context); },
              child: const Text("Logout"),
            ),
          ),
        )
      ]
    );
  }
}


