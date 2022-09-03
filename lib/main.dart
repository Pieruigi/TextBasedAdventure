import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/caching/cacheUtil.dart';
import 'package:textual_adventure/misc/constants.dart';
import '/misc/themes.dart';
import 'views/game_view.dart';
//import 'views/loading_view.dart';
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
      initialRoute: mainRoute,
      routes: {
        mainRoute : (context) => const SafeArea(child: MainView()) ,
        gameRoute: (context) => const GameView(),
        //loadingRoute: (context) => const LoadingView(),
      },
      //home: const MainPage(),
    );
  }
}
