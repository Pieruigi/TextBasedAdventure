import 'package:flutter/foundation.dart';
import 'builder/game_maker.dart';


class GameManager{
  static GameManager? _instance;

  /// Register objects to perform some action after the game has been initialized ( for example to load data from the cache )
  final List<Function> _onGameBuiltCallbacks = [];
  /// Register objects to perform action on game released ( for example to clear data )
  final List<Function> _onGameReleasedCallbacks = [];

  GameManager._(){
    _instance ?? {
      _instance = this
    };
  }

  static GameManager get instance {_instance ?? GameManager._(); return _instance!;}

  /// Game initialization
  void initGame(){
    debugPrint('Init Game');
    // Call the game maker
    GameMaker.instance.create();


    for (var element in _onGameBuiltCallbacks) {element.call();}
  }


  void releaseGame(){
    // Call callbacks
    for (var element in _onGameReleasedCallbacks) {element.call();}
    // Clear callbacks
    _onGameBuiltCallbacks.clear();
    _onGameReleasedCallbacks.clear();
  }

  void registerOnGameBuiltCallback(Function callback){
    _onGameBuiltCallbacks.add(callback);
  }

  void registerOnGameReleasedCallback(Function callback){
    _onGameReleasedCallbacks.add(callback);
  }

/*  void unregisterOnGameInitializedCallback(Function callback){
    _onGameInitializedCallbacks.remove(callback);
  }

  void unregisterOnGameReleasedCallback(Function callback){
    _onGameReleasedCallbacks.remove(callback);
  }*/

}