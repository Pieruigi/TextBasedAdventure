import '/logic/action/base_action.dart';
import '/logic/prompt/base_prompt.dart';
import '../../items/inventory.dart';

/// This class represents the trigger that gives you the ability to pick up any item and store it in your
/// inventory.
class PickUpAction extends BaseAction{

  final BasePrompt pickedUpTarget;
  final BasePrompt failedTarget;

  /// The id of the item you can pick up
  final int itemId;

  PickUpAction(super.description, this.itemId, this.pickedUpTarget, this.failedTarget);

  @override
  BasePrompt doActionImpl() {
    return pickUp() ? pickedUpTarget : failedTarget;
  }

  /// Tries to put the item in the player inventory: returns true on succeed otherwise false ( for example if there is no
  /// room in the player inventory ).
  bool pickUp(){
    return Inventory.instance.add(itemId);
  }
}