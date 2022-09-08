import '/logic/game_manager.dart';

 class Item{

  static final List<Item> _list = [];

  /// The name of the item
  final String name;

  /// A short description
  final String description;

  /// The weight
  final double weight;

  Item({required this.name, this.description = '', this.weight = 0}) {
   GameManager.instance.registerOnGameReleasedCallback(_clear);
   _list.add(this);
  }


  ///
  /// Static methods
  ///
  /// Add a new item in the list
  static void addItem(Item item){
   _list.add(item);
  }

  static int getItemIndex(Item element){
   return _list.indexOf(element);
  }

  static int getLastItemIndex(){
   return _list.indexOf(_list.last);
  }

  ///
  /// Non static methods
  ///

  void _clear(){
   _list.remove(this);
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