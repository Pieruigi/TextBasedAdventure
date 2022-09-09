import 'package:flutter/material.dart';

import '../../action/game_action.dart';
import '../../prompt/game_prompt.dart';

/// Use this class if you simply want to move in a specific direction and nothing is in your
/// path.
/// NB: to walk through a door you might want to use the DoorAction class instead.
/// NB: you can also use move action in dialogs or descriptions.
class CommonAction extends GameAction{

  final GamePrompt _target;

  //CommonAction(description, this._target) : super(description: description);
  CommonAction({required super.code, required super.textCode, required super.hidden, required target}) : _target = target;

  @override
  @protected
  GamePrompt doActionImpl() {
    return _target;
  }


}