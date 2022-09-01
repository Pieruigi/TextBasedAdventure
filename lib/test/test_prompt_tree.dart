import 'package:textual_adventure/logic/actions/door_action.dart';

import '../logic/action_manager.dart';
import '../logic/inventory.dart';
import '../logic/item_manager.dart';
import '/logic/actions/move_action.dart';
import '/logic/actions/base_action.dart';
import '/logic/prompts/base_prompt.dart';
import '/logic/prompt_manager.dart';
import '/logic/prompts/common_prompt.dart';


String _moveNorth = 'Move north';
String _moveSouth = 'Move south';
String _moveEast = 'Move east';
String _moveWest = 'Move west';

void createFakeGameplay(){

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
  al.add(MoveAction(_moveNorth, pl[1]));
  al.add(MoveAction(_moveSouth, pl[2]));
  al.add(MoveAction(_moveEast, pl[3]));
  al.add(MoveAction(_moveWest, pl[4]));

  al.forEach((element) {pl[0].addAction(element); });


}

void _init(){
  // Create singleton managers
  PromptManager();
  ItemManager();
  ActionManager();
  Inventory();
}
//List<BasePrompt> createPrompts()