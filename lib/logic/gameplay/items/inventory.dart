
import 'package:flutter/material.dart';

import '../../caching/cacheUtil.dart';
import '../../game_manager.dart';
import '../../interfaces/i_cacheable.dart';
import 'item.dart';

/// All the items ( medkit, weapons and objects in general ) are stored here.
/// This class is a singleton, means you can access it calling Inventory.instance
class Inventory with ICacheable{

  static Inventory? _instance;

  /// The list of items
  final List<Item> _items = [];

  /// Maximum capacity
  final int _capacity = 20;

  /// Constructor
  Inventory._(){
    _instance ??{
      GameManager.instance.registerOnGameReleasedCallback(_clear),
      _instance == this
    };

  }

  /// Singleton getter
  static Inventory get instance { _instance ?? Inventory._(); return _instance!; }

  /// Try to add a new item
  bool add(Item item){

    // If there is no room return false...
    if(_capacity == _items.length){
      return false;
    }

    //... otherwise add the new item and return true.
    _items.add(item);

    return true;
  }

  /// Remove an existing item: returns true if the item has been removed, otherwise false.
  bool remove(Item item){
    return _items.remove(item);
  }

  void _clear(){
    _items.clear();
  }

  @override
  void fromCacheValue(String data) {
    _clear();
    consumeCache(data.split(cacheSeparator).length, data);
  }

  @override
  void notInCache() {
    _clear();
  }

  @override
  String toCacheValue() {
    List<String> l = [];
    for (var element in _items) { l.add(Item.getItemCode(element)); }
    return appendCache(l, null);
  }



  //set capacity(int value) => _capacity = value;
}
