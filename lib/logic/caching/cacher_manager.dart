import '/logic/game_manager.dart';
import 'cacher.dart';



class CacherManager{

  static CacherManager? _instance;

  final List<Cacher> _cachers = [];

  CacherManager._(){
    _instance ?? {
      GameManager.instance.registerOnGameReleasedCallback(clear),
      _instance = this
    };
  }

  static get instance { _instance ?? CacherManager._(); return _instance; }

  int getCacherIndex(Cacher cacher){
    return _cachers.indexOf(cacher);
  }

  void addCacher(Cacher cacher){
    _cachers.add(cacher);
  }

  void clear(){
    _cachers.clear();
  }


}