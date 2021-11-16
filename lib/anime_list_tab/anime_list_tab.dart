import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/common/custom_bottombar.dart';
import 'package:maki/common/grid_bar.dart';

class list_tab extends StatelessWidget {
  const list_tab({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " Name ",
      // ignore: prefer_const_constructors
      home: listTabScreen(),
    );
  }
}

// ignore: camel_case_types
class listTabScreen extends StatefulWidget {
  const listTabScreen({Key? key}) : super(key: key);

  @override
  listTabScreenState createState() => listTabScreenState();
}

class listTabScreenState extends State<listTabScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      body: customGridBar(),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
