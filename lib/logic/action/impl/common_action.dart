import 'package:flutter/material.dart';

import '/logic/action/base_action.dart';
import '/logic/prompt/base_prompt.dart';

/// Use this class if you simply want to move in a specific direction and nothing is in your
/// path.
/// NB: to walk through a door you might want to use the DoorAction class instead.
/// NB: you can also use move action in dialogs or descriptions.
class CommonAction extends BaseAction{

  final BasePrompt _target;

  CommonAction(super.description, this._target);

  @override
  @protected
  BasePrompt doActionImpl() {
    return _target;
  }


}