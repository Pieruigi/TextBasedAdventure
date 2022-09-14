import 'package:flutter/foundation.dart';

import '../../caching/caching_system.dart';
import '../../game_manager.dart';
import '../action/game_action.dart';
import 'prompt_notifier.dart';

/// This class holds all the decision you can take in a given moment.
/// For example if you are in a room you can choose to look around, or to exit; whichever decision you take will lead you to another prompt.
/// A prompt has a text to describe the actual situation and a list of actions.
abstract class GamePrompt
{
  //static final List<GamePrompt> _list = [];
  static final Map<String, GamePrompt> _map = {};

  // The prompt currently active
  static GamePrompt? _current;

  // Called entering this prompt
  final List<Function(GamePrompt)> _onPromptEnterCallbacks = [];
  // Called exiting this prompt
  final List<Function(GamePrompt)> _onPromptExitCallbacks = [];

  //final String code;

  /// A voice-over describing the current scene.
  final String textCode;

  /// All the actions the player can take in this particular prompt; every action always will lead the player to another prompt.
  final List<GameAction> _actions = [];

  /// Constructor
  GamePrompt({required code, required this.textCode }) {
    // Register callbacks
    GameManager.instance.registerOnGameBuiltCallback(_init);
    GameManager.instance.registerOnGameReleasedCallback(_clear);
    // Add to the list
    //_list.add(this);
    _map[code] = this;

  }

  ///
  /// Static getters and setters
  ///
  //static int get promptCount =>  _list.length;
  static int get promptCount =>  _map.length;
  static GamePrompt get currentPrompt => _current!;

  ///
  /// Getters and setters
  ///
  GamePrompt get current => _current!;

  int get actionCount => _actions.length;

  ///
  /// Static methods
  ///
  static setCurrent(GamePrompt value, bool notify) {

    // Call exit on the old prompt
    _current?.exit();

    // Set the new prompt as the current one
    _current = value;

    // Call enter on the new prompt
    _current!.enter();

    if(notify){
      PromptNotifier.instance.notify();
    }

  }

  static GamePrompt getPromptByCode(String code){
    debugPrint("getPromptByCode('$code')");
    return _map[code]!;
  }

/*  static int getPromptIndex(GamePrompt prompt){
    return _list.indexOf(prompt);
  }*/

/*  static GamePrompt getPromptAtIndex(int index){
    return _list.elementAt(index);
  }*/



  ///
  /// Non static methods
  ///
  /// Add a new action
  void addAction(GameAction value) => _actions.add(value);

  GameAction getActionByIndex(int index){
    return _actions[index];
  }

  void addActionAll(List<GameAction> actions){
    _actions.addAll(actions);
  }

  void _init(){

    if(CachingSystem.instance.isCacheEmpty){
      _map.values.first == this ? setCurrent(this, false) : null;
      //_list.indexOf(this) == 0 ? setCurrent(this) : (){};
    }
    else{
      // InitByCache()
    }
  }

  void enter(){

    for (var element in _onPromptEnterCallbacks) {element.call(this);}
  }

  void exit(){

    for (var element in _onPromptExitCallbacks) {element.call(this);}
  }

  void registerOnPromptExitCallback(Function(GamePrompt) callback){
    _onPromptExitCallbacks.add(callback);
  }

  void registerOnPromptEnterCallback(Function(GamePrompt) callback){
    _onPromptEnterCallbacks.add(callback);
  }

  void unregisterOnPromptExitCallback(Function(GamePrompt) callback){
    _onPromptExitCallbacks.remove(callback);
  }

  void unregisterOnPromptEnterCallback(Function(GamePrompt) callback){
    _onPromptEnterCallbacks.remove(callback);
  }

  void _clear(){
    //_list.remove(this);
    _map.removeWhere((key, value) => value == this);
  }

  @override
  String toString() {
    // TODO: implement toString
    String ret = 'actionCount:${_actions.length}, textCode:$textCode';

    return ret;
  }

  static void debug(){
    String s = '[GamePrompt elements.Count:${_map.length}]';
    _map.forEach((key, value) { s = '$s\n[GamePrompt code:$key, $value]'; });
    debugPrint(s);
  }
}