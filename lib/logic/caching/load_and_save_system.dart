import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '/logic/game_manager.dart';


/// This class takes care of saving and loading stored data.
/// Singleton.
class LoadAndSaveSystem{

    static LoadAndSaveSystem? _instance;

    final String _fileName = 'save.json';

    final List<Function> _onSaveCallbacks = [];

    final List<Function> _onLoadCallbacks = [];

    Map<String, dynamic> _cache =  {};

    LoadAndSaveSystem(){
      _instance ?? {
        GameManager.instance.registerOnGameStartCallback(clear),
        GameManager.instance.registerOnGameStopCallback(clear),
        _instance = this
      };

    }

    static LoadAndSaveSystem get instance { _instance ?? LoadAndSaveSystem(); return _instance!; }

    /// Commonly used by cacher to be reported when save game has been stored
    void registerOnSaveCallback(Function callback){
      _onSaveCallbacks.add(callback);
    }

    /// Commonly used by cachers to be reported when save game has loaded
    void registerOnLoadCallback(Function callback){
      _onLoadCallbacks.add(callback);
    }

    /// Adds or update a pair <key,value> in cache
    void updateCache(String key, dynamic value) => _cache[key] = value;

    /// Gets a value by a given key from cache.
    /// Returns the value or null if the key doesn't exists.
    dynamic getFromCache(String key) => _cache[key];

    /// Clear everything
    void clear(){
      _cache.clear();
      _onSaveCallbacks.clear();
      _onLoadCallbacks.clear();
    }

    /// Returns true if a save game exists
    Future<bool> saveGameExists() async{
      return await File(await _getFilePath()).exists();
    }

    /// Stores data
    Future<void> save() async{
      // Call all the objects that need to be stored to get their value

      if (kDebugMode) {
        print("Callbacks.length:${_onSaveCallbacks.length}");
      }

      for (var value in _onSaveCallbacks) {
        value.call();
      }

      _cache.forEach((key, value) {print('map => $key:$value');});
      await writeFS(jsonEncode(_cache));
    }

    /// Loads data
    Future<void> load() async{

      // Read data from file system
      String data = await readFS();

      // Decode from json to map
      _cache = jsonDecode(data);

      // Debug
      //_cache.forEach((key, value) { print("loaded => $key:$value");});

      // Report all the object that need to be initialized
      for (var value in _onLoadCallbacks) {
        value.call();
      }
    }

    /// Writes on the file system.
    Future<void> writeFS(String data) async{
      // Get the file path
      var filePath = await _getFilePath();

      if (kDebugMode) {
        print('filePath:$filePath');
      }

      // Write the file system
      await File(filePath).writeAsString(data);
    }

    /// Reads from the file system
    Future<String> readFS() async{
      // Get file path
      var filePath = await _getFilePath();

      // Read data
      return await File(filePath).readAsString();
    }

    /// Returns the path of the save game on the file system.
    Future<String> _getFilePath() async{
      // Get base folder
      var dir = await getApplicationDocumentsDirectory();

      // Create file path
      return '${dir.path}/$_fileName';
    }
}

