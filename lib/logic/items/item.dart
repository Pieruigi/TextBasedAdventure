import 'package:textual_adventure/logic/items/inventory.dart';
import 'package:textual_adventure/logic/items/item_manager.dart';

 class Item{

  /// The name of the item
  final String name;

  /// A short description
  final String description;

  /// The weight
  final double weight;

  Item({required this.name, this.description = '', this.weight = 0}) {
   ItemManager.instance.addItem(this);
  }

/*  /// Tries to put the item in the player inventory: returns true on succeed otherwise false ( for example if there is no
  /// room in the player inventory ).
  bool pickUp(){
    return Inventory.instance.add(ItemManager.instance.getItemId(this));
  }

  /// Removes the item from the player inventory.
  void remove(){

  }*/
}