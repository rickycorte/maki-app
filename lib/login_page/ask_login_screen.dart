

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
                padding: const EdgeInsets.only(top: 80.0, left: 100.0, right: 100.0, bottom: 60.0),
                child: Image.asset("assets/images/login_hi.png")
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hi sen(pi)~", style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10.0),
                Text("Please login with your anilist account to:", style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 64,
                  child: ListTile(
                      leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                      title: const Text("Get personalize recommendations"),
                      minLeadingWidth: 5,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 64,
                  child: ListTile(
                      leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                      title: const Text("Get fast access to your list"),
                      minLeadingWidth: 5,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 64,
                  child: ListTile(
                      leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
                      title: const Text("Add suggested anime to your list"),
                      minLeadingWidth: 5,
                  ),
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