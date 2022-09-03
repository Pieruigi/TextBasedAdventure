import 'package:flutter/material.dart';
import 'package:textual_adventure/misc/constants.dart';

import '../logic/game_manager.dart';
import '../misc/themes.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}


class _GameViewState extends State<GameView> {

  bool _initialized = false;

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

    debugPrint('building game_view');

    return WillPopScope(
      onWillPop: () async { return false;},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 10,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              //onTap: ()=> _play(),
              onTap: () => _quit(),
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                child: Center(
                  child: Text('Quit', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
                ),


              ),
            ),

          ),
          const SizedBox(height: 20),
          Material(
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

          ),
        ],
      ),
    );
  }

  void _initGame() {
    GameManager.instance.init().whenComplete(() => { setState(() {
      debugPrint("initialization completed");
      _initialized = true;
    })});
  }

  void _quit(){
    GameManager.instance.quit();
    Navigator.of(context).pushNamed(mainRoute);
  }
}


