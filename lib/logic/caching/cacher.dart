import 'package:flutter/foundation.dart';
import 'package:textual_adventure/logic/caching/cacher_manager.dart';
import 'package:textual_adventure/logic/interfaces/i_cacheable.dart';
import '../game_manager.dart';
import '/logic/caching/load_and_save_system.dart';

class Cacher{

  late String _cacheName;

  final ICacheable _cacheable;

  Cacher(this._cacheable, {String? cacheName}){
    LoadAndSaveSystem.instance.registerOnSaveCallback(_onSave);
    GameManager.instance.registerOnGameInitializedCallback(_tryReadFromCache);
    GameManager.instance.registerOnGameReleasedCallback(_clear);

    // Adds itself to the cache
    CacherManager.instance.addCacher(this);

    if(cacheName != null){
      _cacheName = cacheName;
    }
    else{
      _cacheName = CacherManager.instance.getCacherIndex(this).toString();
    }

  }

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
    GameManager.instance.unregisterOnGameInitializedCallback(_tryReadFromCache);
    GameManager.instance.unregisterOnGameReleasedCallback(_clear);
  }

}