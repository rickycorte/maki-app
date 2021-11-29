

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskLoginScreen extends StatelessWidget{

  Function onLoginButtonPressed;

  AskLoginScreen({Key? key, required this.onLoginButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        children: [ Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 100.0, right: 100.0, bottom: 60.0),
                child: Image.asset("assets/images/login_hi.png")
            ),
            Column(
              children: [
                Text("Hi sen(pi)~", style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10.0),
                Text("You must login with Anilist otherwise we can't:", style: Theme.of(context).textTheme.subtitle1),
                ListTile(
                    leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                    title: const Text("Offer you personalized recommendations")
                ),
                ListTile(
                    leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                    title: const Text("Show your anime list directly in this app")
                ),
                ListTile(
                    leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                    title: const Text("Allow you to add and remove suggested animes from your list")
                ),
              ],
            )
          ],
        ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () => onLoginButtonPressed(),
                child: const Text("Login with Anilist"),
              ),
            ),

          )
        ]
    );
  }

}