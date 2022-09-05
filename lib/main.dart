import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/caching/load_and_save_system.dart';
import 'package:textual_adventure/misc/constants.dart';
import 'package:textual_adventure/views/options_view.dart';
import '/misc/themes.dart';
import 'logic/audio/audio_mixer.dart';
import 'logic/audio/mixer_output.dart';
import 'logic/prefs.dart';
import 'views/game_view.dart';
import 'views/main_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoadAndSaveSystem())
    ],
    /*builder: (context, child) {
          return FutureBuilder(
            future: _init(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return const MyApp();
              }
              else{
                return const null;
              }
            },
          ) ;
        },*/
    child: const MyApp(),
  ));
}

Future<bool> _init() async {
  await Prefs.loadAll();
  debugPrint('prefs loaded');
  _initSimpleMixer();
  debugPrint('mixer initialized');
  return true;
}

/// Creates a master with two children, music and fx.
void _initSimpleMixer() {
  AudioMixer.instance.addMixerOutput(
      MixerOutput(MixerOutputName.master.toString(), AudioMixer.instance),
      children: [
        MixerOutput(MixerOutputName.music.toString(), AudioMixer.instance,
            outputVolume: Prefs.musicVolume),
        MixerOutput(MixerOutputName.fx.toString(), AudioMixer.instance,
            outputVolume: Prefs.fxVolume),
      ]);
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
      initialRoute: mainRoute,
      routes: {
        //mainRoute : (context) => const SafeArea(child: MainView()) ,
        mainRoute: (context) => SafeArea(
              child: FutureBuilder(
                future: _init(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const MainView();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
        gameRoute: (context) => const SafeArea(child: GameView()),
        optionsRoute: (context) => const SafeArea(child: OptionsView()),
        //loadingRoute: (context) => const LoadingView(),
      },
      //home: const MainPage(),
    );
  }


}
