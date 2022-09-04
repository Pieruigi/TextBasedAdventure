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



  List<BaseAction> actions = [];
  List<BasePrompt> prompts = [];



  List<BasePrompt> pl = [];
  pl.add(CommonPrompt('Your adventure starts here.'));
  pl.add(CommonPrompt('You moved north.'));
  pl.add(CommonPrompt('You moved south.'));
  pl.add(CommonPrompt('You moved east.'));
  pl.add(CommonPrompt('You moved west.'));
  prompts = pl;

  //DoorAction(DoorAction.unlocked('description', pl[0], pl[1], pl[2], pl[3], key: ))

  List<BaseAction> al = [];
  al.add(CommonAction(_moveNorth, pl[1]));
  al.add(CommonAction(_moveSouth, pl[2]));
  al.add(CommonAction(_moveEast, pl[3]));
  al.add(CommonAction(_moveWest, pl[4]));

  al.forEach((element) {pl[0].addAction(element); });


}

void _init(){
  // Create singleton managers
  LoadAndSaveSystem();
  PromptManager();
  ItemManager();
  ActionManager();
  Inventory();
}
//List<BasePrompt> createPrompts()