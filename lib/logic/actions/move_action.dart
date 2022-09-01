import '/logic/actions/base_action.dart';
import '/logic/prompts/base_prompt.dart';

/// Use this class if you simply want to move in a specific direction and nothing is in your
/// path.
/// NB: to walk through a door you might want to use the DoorAction class instead.
class MoveAction extends BaseAction{

  final BasePrompt _target;

  MoveAction(super.description, this._target);

  @override
  BasePrompt doActionImpl() {
    return _target;
  }

}