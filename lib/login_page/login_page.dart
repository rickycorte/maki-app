
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maki/login_page/ask_login_screen.dart';
import 'package:maki/models/user.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();

  static void refreshLogin(BuildContext context) {
    context.findAncestorStateOfType<_LoginPageState>()?.refresh();
  }

}

class _LoginPageState extends State<LoginPage> {

  _onLoginButtonPressed() async {
    await User.web_login();
    setState(() {});
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder<bool>(
        future: User.login(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {
            if(User.current != null) {
              // logged in
              return const MyApp();
            } else {
              // not logged in or issues with login
              return AskLoginScreen(onLoginButtonPressed: _onLoginButtonPressed,);
            }

          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}