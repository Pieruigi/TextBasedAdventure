import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/caching/cacheUtil.dart';
import '/misc/themes.dart';
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
