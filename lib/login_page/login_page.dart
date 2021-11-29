
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maki/login_page/ask_login_screen.dart';
import 'package:maki/models/user.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  onLoginButtonPressed() async {
    await User.web_login();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder<bool>(
        future: User.login(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {
            if(!snapshot.hasError && snapshot.hasData && snapshot.data as bool) {
              // logged in
              return Center( child: Text("HELLO ${User.current!.username}!"));
            } else {
              // not logged in or issues with login
              return AskLoginScreen(onLoginButtonPressed: onLoginButtonPressed,);
            }

          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}