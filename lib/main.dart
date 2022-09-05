import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/caching/cacheUtil.dart';
import 'package:textual_adventure/logic/caching/load_and_save_system.dart';
import 'package:textual_adventure/misc/constants.dart';
import '/misc/themes.dart';
import 'views/game_view.dart';
//import 'views/loading_view.dart';
import 'views/main_view.dart';

void main() async {
runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoadAndSaveSystem())
        ],
        child: const MyApp(),
      )
  );

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
        gameRoute: (context) => const SafeArea(child: GameView()),
        optionsRoute: (context) => const SafeArea(child: GameView()),
        //loadingRoute: (context) => const LoadingView(),
      },
      //home: const MainPage(),
    );
  }
}
