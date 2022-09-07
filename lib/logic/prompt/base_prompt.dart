import 'package:textual_adventure/logic/caching/load_and_save_system.dart';
import 'package:textual_adventure/logic/game_manager.dart';
import 'package:textual_adventure/logic/prompt/prompt_manager.dart';
import '/logic/action/base_action.dart';


/// This class holds all the decision you can take in a given moment.
/// For example if you are in a room you can choose to look around, or to exit; whichever decision you take will lead you to another prompt.
/// A prompt has a text to describe the actual situation and a list of actions.
abstract class BasePrompt
{
  // Called entering this prompt
  final List<Function(BasePrompt)> _onPromptEnterCallbacks = [];
  // Called exiting this prompt
  final List<Function(BasePrompt)> _onPromptExitCallbacks = [];

  /// A voice-over describing the current scene.
  final String speech;

  /// All the actions the player can take in this particular prompt; every action always will lead the player to another prompt.
  final List<BaseAction> _actions;

  /// Constructor
/*  BasePrompt(this.speech){

    // Register callbacks
    GameManager.instance.registerOnGameInitializedCallback(_init);
    GameManager.instance.registerOnGameReleasedCallback(_clear);

    // Add itself
    PromptManager.instance.addPrompt(this);
  }*/

  BasePrompt({required this.speech, List<BaseAction> actions = const [] }) : _actions = actions {
    // Register callbacks
    GameManager.instance.registerOnGameInitializedCallback(_init);
    GameManager.instance.registerOnGameReleasedCallback(_clear);

    // Add itself
    PromptManager.instance.addPrompt(this);
  }

  /// Add a new action
  void addAction(BaseAction value) => _actions.add(value);

  int get actionCount => _actions.length;

  BaseAction getActionByIndex(int index){
    return _actions[index];
  }

  void addActionAll(List<BaseAction> actions){
    _actions.addAll(actions);
  }

  void _init(){
    if(LoadAndSaveSystem.instance.isCacheEmpty){
      PromptManager.instance.getPromptIndex(this) == 0 ? PromptManager.instance.current = this : (){};
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

  void _clear(){
    GameManager.instance.unregisterOnGameInitializedCallback(_init);
    GameManager.instance.unregisterOnGameReleasedCallback(_clear);
  }

  void registerOnPromptExitCallback(Function(BasePrompt) callback){
    _onPromptExitCallbacks.add(callback);
  }

  void registerOnPromptEnterCallback(Function(BasePrompt) callback){
    _onPromptEnterCallbacks.add(callback);
  }

  void unregisterOnPromptExitCallback(Function(BasePrompt) callback){
    _onPromptExitCallbacks.remove(callback);
  }

  void unregisterOnPromptEnterCallback(Function(BasePrompt) callback){
    _onPromptEnterCallbacks.remove(callback);
  }

  @override
  String toString() {
    // TODO: implement toString
    String ret = '';

    ret += 'Speech:$speech\n';

    for(BaseAction action in _actions){
      ret += '$action';
    }

    return ret;
  }
}