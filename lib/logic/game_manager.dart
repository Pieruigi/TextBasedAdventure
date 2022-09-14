import 'package:flutter/foundation.dart';
import 'builder/game_maker.dart';

///
/// It's responsible to initialize and release the actual game
///
class GameManager{

  // Singletone instance
  static GameManager? _instance;


  /// This callbacks are called just after the game scaffold has been created, and it's useful to init objects data
  final List<Function> _onGameBuiltCallbacks = [];
  /// Perform release, for example to clear all the game objects lists
  final List<Function> _onGameReleasedCallbacks = [];

  /// Private constructor
  GameManager._(){
    _instance ?? {
      _instance = this
    };
  }

  /// Get instance
  static GameManager get instance {_instance ?? GameManager._(); return _instance!;}

  ///
  /// Game initialization
  /// Here the game is created by reading all the needed json files ( this should be the default way to create the
  /// game sctructure ).
  /// After the game structure has been created all the registred callbacks are called ( an object can register itself
  /// during creation ).
  void initGame(){
    debugPrint('Init Game');
    // Call the game maker
    GameMaker.instance.create();

    // Callbacks
    for (var element in _onGameBuiltCallbacks) {element.call();}
  }

  ///
  /// Called when the player quits the game.
  /// Callbacks are called to eventually perform some releasing process and then they are all cleared.
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