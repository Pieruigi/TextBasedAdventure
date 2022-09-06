import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/logic/prompt/base_prompt.dart';
import 'package:textual_adventure/logic/prompt/prompt_manager.dart';
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

  //const GameView({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameManager.instance.initGame();
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
        /*FutureBuilder(
          //future: GameManager.instance.initGame(),
            builder: (context, snapshot) {
              //if(snapshot.hasData){
              if(true){
                _initialized = true;
                return const GameViewBody();
              }
              else{
                return const LinearProgressIndicator();
              }
            },
        )*/


    );
  }
}


class GameViewBody extends StatelessWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint('building game_view');

    return  Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        PromptView(),
        ButtonQuit(),
        SizedBox(height: 20),
        TestButtonUpdate(),
        SizedBox(height: 20),
        TestButtonSave(),
      ],
    );

  }
}

///
/// Common functions
///
void _quit(BuildContext context){
  GameManager.instance.releaseGame();
  Navigator.of(context).popAndPushNamed(mainRoute);
}

void _save() async{
  await LoadAndSaveSystem.instance.save();
}


///
/// Custom widgets
///
/// Prompt widget
/// This widget handle prompt objects
///
class PromptView extends StatefulWidget {
  const PromptView({Key? key}) : super(key: key);

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  @override
  Widget build(BuildContext context) {

    BasePrompt prompt = context.watch<PromptManager>().current;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [

          SizedBox(
            width: 600,
            height: 250,
            child: Text(prompt.speech, style: commonPromptTheme.textTheme.headline1,),
          ),
          ListView.builder(
            itemCount: prompt.actionCount,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TextButton(
                    onPressed: () => prompt.getActionByIndex(index).doAction(),
                    child: Text(prompt.getActionByIndex(index).description),
                );
              },
          )
        ],
      ),
    )

      ;
  }
}


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