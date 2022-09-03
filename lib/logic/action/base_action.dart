import 'package:textual_adventure/logic/caching/cacheUtil.dart';

import '/logic/prompt/prompt_manager.dart';
import 'action_manager.dart';
import '/logic/prompt/base_prompt.dart';


/// Any instance of this class represents an action the player can do.
/// For example: open the door, take the gun, look around, speak with Peter and so on.
abstract class BaseAction{

  /// A short description telling the player what is going to do.
  final String _description;

  /// Is this action hidden?
  /// For example if you unlock a door this action may become hidden replaced by another than
  /// becomes visible.
  bool _hidden = false;

  /// The target the action we did is leading.
  late BasePrompt _target;

  /// Constructor
  BaseAction(description) : _description = description{
    // Add itself
    ActionManager.instance.addAction(this);
  }

  /// Implement this method in the child class.
  /// Returns the target prompt
  BasePrompt doActionImpl();

  /// This method simply calls the child to perform the actual action and then updates the prompt ( the UI ).
  void doAction(){
    // Execute child method and set the target
    _target = doActionImpl();

    // Update prompt
    _updatePrompt();
  }

  /// This method is call when the player choose this action
  void _updatePrompt(){
    // Set the current prompt
    PromptManager.instance.current = _target;
  }

  set hidden(bool value) => _hidden = value;

  String toCache(){
    return appendCache([_hidden ? 1.toString() : 0.toString()], '');
  }

  void fromCache(String data){
    CacheConsumingResult ccr = consumeCache(1, data);
    _hidden = int.parse(ccr.values[0]) > 0 ? true : false;
  }

  @override
  String toString() {

    String ret = '';

    ret += 'Description:$_description, Hidden:$_hidden\n';

    return ret;
  }
}