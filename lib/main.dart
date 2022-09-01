import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/action_manager.dart';
import 'package:textual_adventure/logic/prompts/base_prompt.dart';
import 'package:textual_adventure/logic/inventory.dart';
import 'package:textual_adventure/logic/item_manager.dart';
import 'package:textual_adventure/logic/prompt_manager.dart';
import 'package:textual_adventure/test/test_prompt_tree.dart';
import 'logic/items/item.dart';

void main() async {



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}



class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Creates all the elements you need to start the game