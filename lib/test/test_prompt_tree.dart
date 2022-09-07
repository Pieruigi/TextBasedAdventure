import '/logic/prompt/prompt_manager.dart';
import '/logic/caching/load_and_save_system.dart';
import '../logic/prompt/impl/common_prompt.dart';
import '../logic/action/action_manager.dart';
import '../logic/items/inventory.dart';
import '../logic/items/item_manager.dart';
import '/logic/prompt/base_prompt.dart';
import '../logic/action/impl/common_action.dart';
import '/logic/action/base_action.dart';


String _moveNorth = 'Move north';
String _moveSouth = 'Move south';
String _moveEast = 'Move east';
String _moveWest = 'Move west';

void createFakeGameplay(){

  _init();

CommonPrompt(
    speech: 'Pippo'

);



}

void _init(){
  // Create singleton managers

}
//List<BasePrompt> createPrompts()