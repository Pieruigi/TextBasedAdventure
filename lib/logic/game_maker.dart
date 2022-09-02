import 'caching/cacher.dart';
import 'prompt/impl/common_prompt.dart';
import 'action/impl/door_action.dart';


class GameMaker{

  static GameMaker? _instance;

  GameMaker(){
    _instance ?? {
      _instance = this
    };
  }

  static GameMaker get instance { _instance ?? GameMaker(); return _instance!; }

  /// This method create all the game structure ( actions, items, etc. ).
  void create(){
    Cacher(DoorAction.unlocked('A simple door unlocked', CommonPrompt('You came from the door')));
    Cacher(DoorAction.locked('A simple door locked', CommonPrompt('This door is locked')));
  }
}