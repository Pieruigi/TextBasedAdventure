import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'views/game_view.dart';
import 'views/initialization_view.dart';
import 'views/main_view.dart';
import 'views/misc/themes.dart';

import 'logic/caching/caching_system.dart';
import 'logic/gameplay/prompt/prompt_notifier.dart';
import 'views/options_view.dart';

///
/// Routes
///
const String mainRoute = '/main';
const String gameRoute = '/game';
const String optionsRoute = '/options';
const String initializationRoute = '/initialization';

void main(){

  runApp(
        MultiProvider(
          providers: [
            // Notify when a prompt changes ( a prompt is what the player is currently playing or seeing )
            ChangeNotifierProvider(create: (context) => PromptNotifier.instance),
            // Notify when game is going to be saved
            ChangeNotifierProvider(create: (context) => CachingSystem.instance)
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





