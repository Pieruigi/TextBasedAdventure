import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/audio/audio_player_data.dart';
import 'package:textual_adventure/logic/audio/audioclip.dart';
import 'package:textual_adventure/misc/constants.dart';
import '../logic/prefs.dart';
import '/logic/caching/load_and_save_system.dart';
import '/misc/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AudioPlayerData? _audioPlayer;

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  void _playMusic(){
    if(_audioPlayer ==  null || _audioPlayer!.isDisposed)  {
      _audioPlayer = AudioPlayerData(AudioMixer.instance.getMixerOutput(MixerOutputName.music.toString()));
    }

    if(!_audioPlayer!.isPlaying){
      _audioPlayer!.play(audioclip: Audioclip('audio/example.mp3', volume: 1), loop: true);
    }
  }

  @override
  Widget build(BuildContext context) {

    debugPrint('main widget');
    //Prefs.loadAll();

    //Future.delayed(const Duration(seconds: 10),() => _playMusic());
    _playMusic();

    debugPrint('building main_view');
    return Scaffold(
      //backgroundColor: Colors.black87,
      backgroundColor: mainTheme.backgroundColor,
      body:
          Container(
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
          )
    );
  } // Main View

}


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



class ButtonPlayGame extends StatelessWidget {
  const ButtonPlayGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                  onTap: () { _audioPlayer!.dispose(); _audioPlayer = null; Navigator.of(context).popAndPushNamed(gameRoute);},
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



class ButtonDeleteSaveGame extends StatefulWidget {
  const ButtonDeleteSaveGame({Key? key}) : super(key: key);

  @override
  State<ButtonDeleteSaveGame> createState() => _ButtonDeleteSaveGameState();
}

class _ButtonDeleteSaveGameState extends State<ButtonDeleteSaveGame> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    context.watch<LoadAndSaveSystem>();

    return FutureBuilder<bool>(
      future: LoadAndSaveSystem.instance.saveGameExists(),
      builder: ((context, snapshot) {
        if(snapshot.hasData){
          return       Material(
            elevation: 10,
            color: snapshot.data! ? Colors.redAccent : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () => snapshot.data! ? _delete(context) : null,
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
        else{
          return const CircularProgressIndicator();
        }

      })

    );
    

  }

  Future<void> _delete(BuildContext context) async{
    bool ret = false;
    ret = (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteSavedGame),
          content: Text(AppLocalizations.of(context)!.deleteSavedGameMsg),
          actions: [
            TextButton(child: Text(AppLocalizations.of(context)!.yes), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: Text(AppLocalizations.of(context)!.no), onPressed: () => Navigator.of(context).pop(false)),
          ],
        )
    )
    ) ?? false;

    ret ? LoadAndSaveSystem.instance.delete() : null;
  }
}

