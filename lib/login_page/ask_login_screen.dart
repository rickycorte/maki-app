

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskLoginScreen extends StatelessWidget{

  Function onLoginButtonPressed;

  AskLoginScreen({Key? key, required this.onLoginButtonPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        children: [ ListView(
          primary: false,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 450),
              child: Padding(
                  padding: const EdgeInsets.only(top: 80.0, left: 100.0, right: 100.0, bottom: 60.0),
                  child: Image.asset("assets/images/login_hi.png")
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Hi sen(pi)~", style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 15.0),
                  Text("Please login with your Anilist account to:", style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "Get personalized recommendations",
                      "Access your anime list within the app",
                      "Add and remove anime to your list"
                    ].map((msg) =>
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Theme.of(context).primaryColor),
                              const SizedBox(width: 5,),
                              Text(msg, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                        ),
                    ).toList(),
                  ),
                ],
              ),
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