import 'package:flutter/material.dart';

import '../../action/game_action.dart';
import '../../prompt/game_prompt.dart';
import '../../items/inventory.dart';

/// This class represents the trigger that gives you the ability to pick up any item and store it in your
/// inventory.
class PickUpAction extends GameAction{

  final GamePrompt pickedUpTarget;
  final GamePrompt? failedTarget;

  /// The id of the item you can pick up
  final int itemId;

  //PickUpAction(description, this.itemId, this.pickedUpTarget, this.failedTarget) : super(description: description);
  PickUpAction({required super.textId, required super.hidden, required this.itemId, required this.pickedUpTarget,  this.failedTarget});

  @override
  @protected
  GamePrompt doActionImpl() {
    return pickUp() ? pickedUpTarget : failedTarget!;
  }

  /// Tries to put the item in the player inventory: returns true on succeed otherwise false ( for example if there is no
  /// room in the player inventory ).
  bool pickUp(){
    return Inventory.instance.add(itemId);
  }
}