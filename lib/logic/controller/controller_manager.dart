import 'package:textual_adventure/logic/game_manager.dart';
import 'package:textual_adventure/logic/interfaces/i_clearable.dart';

import 'action_controller.dart';

class ControllerManager {

  static ControllerManager? _instance;

  final List<Object> _controllers = [];

  ControllerManager._(){
    _instance ?? {
      GameManager.instance.registerOnGameReleasedCallback(clear),
      _instance = this,
    };
  }

  static ControllerManager get instance { _instance ?? ControllerManager._(); return _instance!; }


  void addController(Object controller){
    _controllers.add(controller);
  }

  void removeController(Object controller){
    _controllers.remove(controller);
  }

  void clear(){
    for (var element in _controllers) {(element as IClearable).clear();}
    _controllers.clear(); // To be sure
  }
}