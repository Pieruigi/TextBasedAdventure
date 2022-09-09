import 'package:textual_adventure/logic/builder/models/action/game_action_model.dart';

import '../prompt/game_prompt_model.dart';

class DoorActionModel extends GameActionModel{

  String? isUnlockedTargetCode; // key=uTarget
  String? failedTargetCode; // key=fTarget
  String? isLockedTargetCode; // key=lTarget
  bool locked; // key=locked
  String? keyCode; // key=keyCode

  ///
  /// target: the walkThroughTarget ( after you open the door )
  DoorActionModel({
    required super.code,
    required super.textCode,
    required super.targetCode,
    super.hidden,
    this.isUnlockedTargetCode,
    this.failedTargetCode,
    this.isLockedTargetCode,
    this.locked = false,
    this.keyCode
  });

  @override
  String toString() {
    // TODO: implement toString
    return "[DoorActionModel code:$code, textCode:$textCode, targetCode:$targetCode], hidden:$hidden, locked:$locked, key:$keyCode, uTargetCode:$isUnlockedTargetCode, fTargetCode:$failedTargetCode, lTargetCode:$isLockedTargetCode]";
  }

}