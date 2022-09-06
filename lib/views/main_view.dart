import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/audio/audio_player_data.dart';
import 'package:textual_adventure/logic/audio/audioclip.dart';
import 'package:textual_adventure/misc/constants.dart';
import '/logic/caching/load_and_save_system.dart';
import '/misc/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'commons.dart';



class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Check the utilities section
    if(_playMusic) _initMusicPlayerAndPlay();

    return WillPopScope(
      onWillPop: () { return messageBox(
        context: context,
          title: 'Exit',
          content: 'Do you want to quit the game?',
          yesText: AppLocalizations.of(context)!.yes,
          noText: AppLocalizations.of(context)!.no,
          yesFunc:  ()=>debugPrint('Quitting'),
          noFunc:   ()=>debugPrint('Aborting')
      ); },
      child: Scaffold(
      //backgroundColor: Colors.black87,
      backgroundColor: mainTheme.backgroundColor,
      body:
      const MainViewBody(),
      ),
    );


  } // Main View


}

///
/// Custom widgets
///
/// The main widget body
class MainViewBody extends StatelessWidget {
  const MainViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint('creating main view');


    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.yellow, width: 3.0, style: BorderStyle.solid)),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 200),
      child:
      Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: const [

            ButtonPlayGame(),

            SizedBox(height: 20),
            ButtonOptions(),
            SizedBox(height: 20),
            SizedBox(height: 20),
            SizedBox(height: 20),
            SizedBox(height: 20),

            ButtonDeleteSaveGame(),

          ]

      ) ,
    );
  }
}


///
/// Creates a button to open the option menu
class ButtonOptions extends StatelessWidget {
  const ButtonOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () {Navigator.of(context).popAndPushNamed(optionsRoute);},
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text(AppLocalizations.of(context)!.options, textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
          ),

        ),
      ),

    );
  }
}

///
/// Creates the button to start the game
class ButtonPlayGame extends StatelessWidget {
  const ButtonPlayGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () => { _stopAndDisposeMusicPlayer(), Navigator.of(context).popAndPushNamed(gameRoute) },
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text(AppLocalizations.of(context)!.play, textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
          ),

        ),
      ),

    );
  }
}

///
/// Create the button to delete the game
class ButtonDeleteSaveGame extends StatefulWidget {
  const ButtonDeleteSaveGame({Key? key}) : super(key: key);

  @override
  State<ButtonDeleteSaveGame> createState() => _ButtonDeleteSaveGameState();
}

class _ButtonDeleteSaveGameState extends State<ButtonDeleteSaveGame> {


  @override
  Widget build(BuildContext context) {

    debugPrint('Build delete button');
    context.watch<LoadAndSaveSystem>();

    return Material(
      elevation: 10,
      color: LoadAndSaveSystem.instance.isGameSaved ? Colors.redAccent : Colors.grey,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () => LoadAndSaveSystem.instance.isGameSaved ? _deleteSaveGame(context) : null,
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text(AppLocalizations.of(context)!.deleteSavedGame, textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
          ),

        ),
      ),

    );


  }


}

///
/// Utilities
///

///
/// Set _playMusic true if you want to play music on the menu
AudioPlayerData? _musicPlayer;
const bool _playMusic = false;
const String _clipPath = 'audio/example.mp3';

void _initMusicPlayerAndPlay(){
  if(_musicPlayer ==  null || _musicPlayer!.isDisposed)  {
    _musicPlayer = AudioPlayerData(AudioMixer.instance.getMixerOutput(MixerOutputName.music.toString()));
  }

  if(!_musicPlayer!.isPlaying){
    _musicPlayer!.play(audioclip: Audioclip(_clipPath, volume: 1), loop: true);
  }
}

void _stopAndDisposeMusicPlayer(){
  if(!_playMusic){
    return;
  }
  _musicPlayer!.dispose();
  _musicPlayer = null;
}

void _deleteSaveGame(BuildContext context){
  messageBox(
      context: context,
      title: AppLocalizations.of(context)!.deleteSavedGame,
      content: AppLocalizations.of(context)!.deleteSavedGameMsg,
      yesText: AppLocalizations.of(context)!.yes,
      noText: AppLocalizations.of(context)!.no,
      yesFunc: () => { LoadAndSaveSystem.instance.delete() },
      noFunc: () => {}
      );
}