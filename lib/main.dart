import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/prompt/prompt_manager.dart';
import '/logic/caching/load_and_save_system.dart';
import '/misc/constants.dart';
import 'test/test_json.dart';
import 'views/initialization_view.dart';
import 'views/options_view.dart';
import 'misc/themes.dart';
import '/views/game_view.dart';
import 'views/main_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async{

  runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PromptManager.instance),
            ChangeNotifierProvider(create: (context) => LoadAndSaveSystem.instance)
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
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('it'),
              ],
              theme: mainTheme,
              initialRoute: initializationRoute,
              routes: {
                initializationRoute: (context) => const SafeArea(child: InitializationView()),
                mainRoute : (context) => const SafeArea(child: MainView()),
                gameRoute: (context) => const SafeArea(child: GameView()),
                optionsRoute: (context) => const SafeArea(child: OptionsView()),

              },

            );

  }
}





