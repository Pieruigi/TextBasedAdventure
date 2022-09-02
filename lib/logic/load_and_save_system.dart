/// This class takes care of saving and loading stored data.
/// Singleton.
class LoadAndSaveSystem{

    static LoadAndSaveSystem? _instance;

    final String _path = '/save.json';

    final List<Function> _saveCallbacks = [];

    LoadAndSaveSystem(){
      _instance ??= this;
      _saveCallbacks.add(_textCall);
    }

    static LoadAndSaveSystem get instance { _instance ?? LoadAndSaveSystem(); return _instance!; }

    void addSaveCallback(Function callback){
      _saveCallbacks.add(callback);
    }

    /// Store data
    void save(){
      for (var value in _saveCallbacks) {
        value.call();
      }
    }

    /// Load data
    void load(){

    }
}

void _textCall(){
  print('calling...');
}