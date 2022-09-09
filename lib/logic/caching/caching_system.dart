import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';


/// This class takes care of saving and loading stored data.
/// Singleton.
class CachingSystem extends ChangeNotifier{

    static CachingSystem? _instance;

    final String _fileName = 'save.json';

    final List<Function> _onSaveCallbacks = [];

    Map<String, dynamic> _cache =  {};

    bool _gameSaved = false;

    bool _initialized = false;

    CachingSystem._(){
      debugPrint('Creating loadAndSaveSystem');
      _instance ?? {
        _instance = this,
      };

    }

    static CachingSystem get instance { _instance ?? CachingSystem._(); return _instance!; }

    bool get isGameSaved {
      if(!_initialized){ throw Exception('LoadAndSaveSystem must be initialized first.'); }
      return _gameSaved;
    }

    bool get isCacheEmpty => _cache.isEmpty;

    Future initialize() async{
      _gameSaved = await _isGameSaved();
      _initialized = true;
    }


    /// Commonly used by cacher to be reported when save game has been stored
    void registerOnSaveCallback(Function callback){
      _onSaveCallbacks.add(callback);
    }

    void unregisterOnSaveCallback(Function callback){
      _onSaveCallbacks.remove(callback);
    }

    /// Adds or update a pair <key,value> in cache
    void updateCache(String key, dynamic value) => _cache[key] = value;

    /// Gets a value by a given key from cache.
    /// Returns the value or null if the key doesn't exists.
    dynamic getFromCache(String key) => _cache[key];

    /// Clear everything
    void clear(){
      _cache.clear();
    }

    /// Returns true if a save game exists
    Future<bool> _isGameSaved() async{
      return await File(await _getFilePath()).exists();
    }

/*    Future<bool> saveGameExists() async{
      return await File(await _getFilePath()).exists();
    }*/

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
      _gameSaved = true;
    }

    /// Loads data
    Future<void> load() async{

      debugPrint('Loading saved game...');

      if(!_gameSaved){
        throw Exception('No save game has been found.');
      }

      // Read data from file system
      String data = await readFS();

      // Decode from json to map
      _cache = jsonDecode(data);

      debugPrint('Loading completed');
    }

    Future<void> delete() async{
      debugPrint('Deleting...');
      await File(await _getFilePath()).delete();
      //await Future.delayed(const Duration(seconds: 1));
      _gameSaved = false;
      notifyListeners();
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

