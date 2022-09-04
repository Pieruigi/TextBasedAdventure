import 'package:textual_adventure/logic/prompt/prompt_manager.dart';
import '/logic/action/base_action.dart';


/// This class holds all the decision you can take in a given moment.
/// For example if you are in a room you can choose to look around, or to exit; whichever decision you take will lead you to another prompt.
/// A prompt has a text to describe the actual situation and a list of actions.
abstract class BasePrompt
{
  /// A voice-over describing the current scene.
  final String speech;

  /// All the actions the player can take in this particular prompt; every action always will lead the player to another prompt.
  final List<BaseAction> _actions = [];

  /// Constructor
  BasePrompt(this.speech){
    // Add itself
    PromptManager.instance.addPrompt(this);
  }

  /// Add a new action
  void addAction(BaseAction value) => _actions.add(value);


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