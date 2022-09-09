import 'package:textual_adventure/logic/builder/models/action/game_action_model.dart';

class CommonActionModel extends GameActionModel{

  CommonActionModel({required super.code, required super.textCode, required super.targetCode, super.hidden = false});

  @override
  String toString() {
    // TODO: implement toString
    return "[CommonActonModel code:$code, textCode:$textCode, targetCode:$targetCode], hidden:$hidden]";
  }
}