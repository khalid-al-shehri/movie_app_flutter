import 'package:flutter/material.dart';
import 'package:movie_app_sdaia/screen/mainScreen.dart';
import 'package:movie_app_sdaia/widgets/searchField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen().id,
      routes: {
        MainScreen().id : (context) => MainScreen()
      },
    );
  }
}

