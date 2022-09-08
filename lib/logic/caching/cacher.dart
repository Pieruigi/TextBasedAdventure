import 'package:flutter/foundation.dart';
import '/logic/interfaces/i_cacheable.dart';
import '/logic/game_manager.dart';
import '/logic/caching/load_and_save_system.dart';

class Cacher{

  static final List<Cacher> _list = [];

  late String _cacheName;

  final ICacheable _cacheable;

  Cacher(this._cacheable, {String? cacheName}){
    LoadAndSaveSystem.instance.registerOnSaveCallback(_onSave);
    GameManager.instance.registerOnGameBuiltCallback(_tryReadFromCache);
    GameManager.instance.registerOnGameReleasedCallback(_clear);

    // Adds itself to the cache
    _list.add(this);

    // The cache name
    if(cacheName != null){
      _cacheName = cacheName;
    }
    else{ // Suggested
      _cacheName = getCacherIndex(this).toString();
    }


  }

  ///
  /// Static methods
  ///
  static int getCacherIndex(Cacher cacher){
    return _list.indexOf(cacher);
  }

  ///
  /// Non static methods
  ///
  /// Gets data from the cacheable object.
  void _onSave(){
    // We need to get specific data from the child
    String data = _cacheable.toCacheValue();
    if (kDebugMode) {
      print('$_cacheName:$data');
    }

    LoadAndSaveSystem.instance.updateCache(_cacheName, data);

  }

  void _tryReadFromCache(){
    String? data = LoadAndSaveSystem.instance.getFromCache(_cacheName);

    if(data != null){
      _cacheable.fromCacheValue(data);
    }

  }

  void _clear(){
    LoadAndSaveSystem.instance.unregisterOnSaveCallback(_onSave);
    _list.remove(this);
  }

}