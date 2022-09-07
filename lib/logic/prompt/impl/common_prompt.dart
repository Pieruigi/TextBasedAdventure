import '../../action/base_action.dart';
import '/logic/prompt/base_prompt.dart';

/// This is the most common prompt of the game, where you can make common actions, like moving,
/// picking up items, interacting with objects etc.
class CommonPrompt extends BasePrompt{

  //CommonPrompt(super.speech);
  CommonPrompt({required speech, List<BaseAction> actions = const []}) : super(speech: speech, actions: actions);

}