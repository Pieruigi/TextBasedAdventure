import 'package:flutter/material.dart';
import 'package:textual_adventure/misc/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../logic/audio/audio_player_data.dart';
import '../logic/caching/load_and_save_system.dart';
import '../logic/game_manager.dart';
import '../misc/themes.dart';
import 'commons.dart';

AudioPlayerData? _musicPlayer;
AudioPlayerData? _ambientPlayer;
AudioPlayerData? _fxPlayer;


class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {

  bool _initialized = false;

  void _initGame() {
    GameManager.instance.init().whenComplete(() => { setState(() {
      debugPrint("initialization completed");
      _initialized = true;
    })});
  }

  //const GameView({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint("Initializing game view state");
    // initState() is called the first time every time the game view is created
    _initGame();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () { return messageBox(
          context: context,
          title: AppLocalizations.of(context)!.quitGame,
          content: AppLocalizations.of(context)!.quitGameMsg,
          yesFunc: () { _quit(context); },
          noFunc: () {},
          yesText: AppLocalizations.of(context)!.yes,
          noText: AppLocalizations.of(context)!.no,
        );},
        child: const GameViewBody(),

    );
  }
}


class GameViewBody extends StatelessWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint('building game_view');

    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ButtonQuit(),
        SizedBox(height: 20),
        TestButtonUpdate(),
        SizedBox(height: 20),
        TestButtonSave(),
      ],
    );

  }
}



void _save() async{
  await LoadAndSaveSystem.instance.save();
}



///
/// Custom widgets
///
class ButtonQuit extends StatefulWidget {
  const ButtonQuit({Key? key}) : super(key: key);

  @override
  State<ButtonQuit> createState() => _ButtonQuitState();
}

class _ButtonQuitState extends State<ButtonQuit> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () => _quit(context),
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text('Quit', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
          ),


        ),
      ),

    );
  }
}

///
/// Common functions
///
void _quit(BuildContext context){
  GameManager.instance.quit();

  Navigator.of(context).popAndPushNamed(mainRoute);

}


///
/// Test widgets
///
class TestButtonUpdate extends StatefulWidget {
  const TestButtonUpdate({Key? key}) : super(key: key);

  @override
  State<TestButtonUpdate> createState() => _TestButtonUpdateState();
}

class _TestButtonUpdateState extends State<TestButtonUpdate> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        //onTap: ()=> _play(),
        onTap: () => setState(() {

        }),
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text('Update', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
          ),


        ),
      ),

    );
  }
}

class TestButtonSave extends StatefulWidget {
  const TestButtonSave({Key? key}) : super(key: key);

  @override
  State<TestButtonSave> createState() => _TestButtonSaveState();
}

class _TestButtonSaveState extends State<TestButtonSave> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: ()=> _save(),
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text('Save', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
          ),


        ),
      ),

    );
  }
}
