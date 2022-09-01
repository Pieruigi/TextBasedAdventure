import 'items/item.dart';

/// All the items ( medkit, weapons and objects in general ) are stored here.
/// This class is a singleton, means you can access it calling Inventory.instance
class Inventory{

  static Inventory? _instance;

  /// The list of items
  final List<int> _itemIds = [];

  /// Maximum capacity
  final int _capacity = 20;

  /// Constructor
  Inventory(){
    // Singleton
    _instance ??= this;
  }

  /// Singleton getter
  static Inventory get instance { _instance ?? Inventory(); return _instance!; }

  /// Try to add a new item
  bool add(int itemId){

    // If there is no room return false...
    if(_capacity == _itemIds.length){
      return false;
    }

    //... otherwise add the new item and return true.
    _itemIds.add(itemId);

    return true;
  }

  /// Remove an existing item: returns true if the item has been removed, otherwise false.
  bool remove(int itemId){
    return _itemIds.remove(itemId);
  }

  //set capacity(int value) => _capacity = value;
}