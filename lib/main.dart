import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/action_manager.dart';
import 'package:textual_adventure/logic/prompts/base_prompt.dart';
import 'package:textual_adventure/logic/inventory.dart';
import 'package:textual_adventure/logic/item_manager.dart';
import 'package:textual_adventure/logic/prompt_manager.dart';
import 'package:textual_adventure/misc/themes.dart';
import 'package:textual_adventure/test/test_prompt_tree.dart';
import 'logic/items/item.dart';
import 'views/game_view.dart';
import 'views/main_view.dart';


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
      theme: mainTheme,
      initialRoute: '/',
      routes: {
        '/' : (context) => const SafeArea(child: MainView()) ,
        '/game': (context) => const GameView(),
      },
      //home: const MainPage(),
    );
  }
}




/// Creates all the elements you need to start the game
