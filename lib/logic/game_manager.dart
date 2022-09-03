import 'package:flutter/foundation.dart';
import 'caching/load_and_save_system.dart';
import 'game_maker.dart';


class GameManager{
  static GameManager? _instance;

  GameManager(){
    _instance ?? {
      _instance = this
    };
  }

  /// Any instance can register a callback to get reported when the game starts.
  final List<Function> _onGameStartCallbacks = [];
  final List<Function> _onGameStopCallbacks = [];

  bool _inGame = false; // Is the player in game ?
  bool _newGame = false; // Is the player starting a new game ?


  static GameManager get instance {_instance ?? GameManager(); return _instance!;}

  /// _newGame getter
  bool get isNewGame => _newGame;

  bool get isInGame => _inGame;

  /// This methods is called both when the player wants to start a new game or to load an existing one.
  /// The game is started and the GameMaker is called in order to create the gameplay: when the gameplay has been created
  /// the game manager looks for a save game by calling the LoadAndSaveSystem; if a save game exists the LoadAndSaveSystem.load() is
  /// called and then all the Cacher instances callbacks are called in order to initialize the objects whose state is stored
  /// in the cache.
  Future<void> init() async{

    _inGame = true;

    // Report all the object that registered a callback that the game is going to start ( normally you can do some cleaning here )
    //for (var func in _onGameStartCallbacks) {func.call();}

    // Check if the player is playing a new game or if is loading a save game.
    if(await LoadAndSaveSystem.instance.saveGameExists()){
      if (kDebugMode) {
        print('Loading an existing game');
      }

      // It's not a new game
      _newGame = false;
    }
    else{
      if (kDebugMode) {
        print('Starting a new game');
      }

      // It's a new game
      _newGame = true;
    }

    // Start the game ( you can call the GameMaker here )
    _create();

    // If is not a new game then load data in cache and init game objects
    if(!_newGame){
      await LoadAndSaveSystem.instance.load();
    }


  }

  /// An object can register a function to get reported when the game starts ( commonly used for initialization )
  void registerOnGameStartCallback(Function callback){
    _onGameStartCallbacks.add(callback);
  }

  /// An object can register a function to get reported when the game stops ( commonly used for cleaning )
  void registerOnGameStopCallback(Function callback){
    _onGameStopCallbacks.add(callback);
  }

  void _create(){
    GameMaker.instance.create();
  }


  void quit(){

    for(Function func in _onGameStopCallbacks) { func.call(); }

    _inGame = false;
  }

}