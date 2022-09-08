import '/logic/action/base_action.dart';
import '/logic/game_manager.dart';
import '/logic/prompt/base_prompt.dart';

/// This class map actions to a prompt in a way that you can activate or deactivate actions when the player enters or exits a specific
/// prompt ( for example when you enter the prompt after you picked a key you can enable the action "use the key" to open a door.
class ActionController{

  static final List<ActionController> _list = [];

  /// The list of actions you want to activate when you enter or exit the prompt
  final List<BaseAction>? activatingList;

  /// The list of actions you want to deactivate when you enter or exit the prompt
  final List<BaseAction>? deactivatingList;

  /// The prompt you want the player to enter/exit in order to trigger this controller
  final BasePrompt prompt;

  /// True if you want to trigger entering the prompt ( default )
  final bool triggerOnEnter;

  /// True if you want to trigger on exit ( default is false ); if both triggerOnEnter and triggerOnExit are true then triggerOnExit
  /// will reverse the lists ( so the objects in the activatingList are deactivated and the ones in the deactivating list
  /// are activated again )
  final bool triggerOnExit;

  ActionController({required this.prompt, this.activatingList, this.deactivatingList, this.triggerOnEnter = true, this.triggerOnExit = false}){
    // Check params
    if(activatingList == null && deactivatingList == null){ throw Exception('Both the activating and the deactivating lists are null in the action controller.'); }
    if(!triggerOnEnter && !triggerOnExit){ throw Exception('Both on enter and on exit triggers are null in the action controller'); }

    GameManager.instance.registerOnGameReleasedCallback(_clear);

    // Add to the controller manager
    _list.add(this);

    // Register callbacks
    if(triggerOnEnter){
      prompt.registerOnPromptEnterCallback((p0) => _onEnter);

    }

    if(triggerOnExit){
      prompt.registerOnPromptExitCallback((p0) => _onExit);

    }

  }

  void _activateAll(bool value, List<BaseAction> actions){
      for (var element in actions) {element.hidden = value;}
  }

  void _onEnter(){
    if(activatingList != null){
      _activateAll(true, activatingList!);
    }
    if(deactivatingList != null){
      _activateAll(false, deactivatingList!);
    }
  }

  void _onExit(){
    if(activatingList != null){
      _activateAll(!triggerOnEnter, activatingList!);
    }
    if(deactivatingList != null){
      _activateAll(triggerOnEnter, deactivatingList!);
    }
  }


  void _clear(){
    if(triggerOnEnter) {prompt.unregisterOnPromptEnterCallback((p0) => _onEnter);}
    if(triggerOnExit) { prompt.unregisterOnPromptExitCallback((p0) => _onExit);}
    _list.remove(this);
  }
}