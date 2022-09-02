import 'package:flutter/foundation.dart';
import 'package:textual_adventure/logic/caching/cacher_manager.dart';
import 'package:textual_adventure/logic/interfaces/i_cacheable.dart';
import '/logic/caching/load_and_save_system.dart';

class Cacher{

  late String _cacheName;

  final ICacheable _cacheable;

  Cacher(this._cacheable, {String? cacheName}){
    LoadAndSaveSystem.instance.registerOnLoadCallback(_onLoad);
    LoadAndSaveSystem.instance.registerOnSaveCallback(_onSave);

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
    String data = _cacheable.toCache();
    if (kDebugMode) {
      print('$_cacheName:$data');
    }

    LoadAndSaveSystem.instance.updateCache(_cacheName, data);
    //'$_cacheName:$data';
  }

  void _onLoad(){
    String? data = LoadAndSaveSystem.instance.getFromCache(_cacheName);

    if(data != null){
      _cacheable.fromCache(data);
    }

  }


}