import 'package:textual_adventure/logic/interfaces/i_cacheable.dart';

import '/logic/caching/chaching_system.dart';
import '/logic/game_manager.dart';
import '/logic/prompt/prompt_notifier.dart';
import '/logic/action/base_action.dart';


/// This class holds all the decision you can take in a given moment.
/// For example if you are in a room you can choose to look around, or to exit; whichever decision you take will lead you to another prompt.
/// A prompt has a text to describe the actual situation and a list of actions.
abstract class BasePrompt
{
  static final List<BasePrompt> _list = [];

  // The prompt currently active
  static BasePrompt? _current;

  // Called entering this prompt
  final List<Function(BasePrompt)> _onPromptEnterCallbacks = [];
  // Called exiting this prompt
  final List<Function(BasePrompt)> _onPromptExitCallbacks = [];

  /// A voice-over describing the current scene.
  final String speech;

  /// All the actions the player can take in this particular prompt; every action always will lead the player to another prompt.
  final List<BaseAction> _actions;

  /// Constructor
  BasePrompt({required this.speech, List<BaseAction> actions = const [] }) : _actions = actions {
    // Register callbacks
    GameManager.instance.registerOnGameBuiltCallback(_init);
    GameManager.instance.registerOnGameReleasedCallback(_clear);
    // Add to the list
    _list.add(this);

  }

  BasePrompt get current => _current!;

  int get actionCount => _actions.length;

  ///
  /// Static methods
  ///
  static setCurrent(BasePrompt value) {

    // Call exit on the old prompt
    _current?.exit();

    // Set the new prompt as the current one
    _current = value;

    // Call enter on the new prompt
    _current!.enter();

    PromptNotifier.instance.notify(_current!);

  }

  static int getPromptIndex(BasePrompt prompt){
    return _list.indexOf(prompt);
  }

  ///
  /// Non static methods
  ///
  /// Add a new action
  void addAction(BaseAction value) => _actions.add(value);

  BaseAction getActionByIndex(int index){
    return _actions[index];
  }

  void addActionAll(List<BaseAction> actions){
    _actions.addAll(actions);
  }

  void _init(){
    if(CachingSystem.instance.isCacheEmpty){
      _list.indexOf(this) == 0 ? setCurrent(this) : (){};
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

  void _clear(){
    _list.remove(this);
  }

  @override
  String toString() {
    // TODO: implement toString
    String ret = '[PromptList Length:${_list.length}]';

    ret += 'Speech:$speech\n';

    for(BaseAction action in _actions){
      ret += '$action';
    }

    return ret;
  }
}