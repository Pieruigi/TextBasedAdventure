

 import '../../game_manager.dart';

class Item{

  static final Map<String, Item> _map = {};

  /// The name of the item
  final String nameCode;

  /// A short description
  final String textCode;

  /// The weight
  final double weight;

  Item({required String code, required this.nameCode, this.textCode = '', this.weight = 0}) {
   GameManager.instance.registerOnGameReleasedCallback(_clear);
   _map[code] = this;
  }

  static Item getItemByCode(String code){
    return _map[code]!;
  }

  static String getItemCode(Item item){
    return _map.keys.firstWhere((element) => _map[element] == item);
  }

  ///
  /// Static methods
  ///
  /// Add a new item in the list
/*  static void addItem(Item item){
   _list.add(item);
  }

  static int getItemIndex(Item element){
   return _list.indexOf(element);
  }

  static int getLastItemIndex(){
   return _list.indexOf(_list.last);
  }*/

  ///
  /// Non static methods
  ///

  void _clear(){
   _map.removeWhere((key, value) => value == this);
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