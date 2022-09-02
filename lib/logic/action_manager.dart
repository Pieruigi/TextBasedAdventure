import 'actions/base_action.dart';

/// It creates and stores all the items in the game into a list.
/// It's a singleton.
class ActionManager{

  /// For singleton
  static ActionManager? _instance;

  final List<BaseAction> _actions = [];

  /// Constructor
  ActionManager(){
    _instance ?? {
      _init(),
      _instance = this
    };


  }


  static ActionManager get instance {
    _instance ?? ActionManager();

    return _instance!;
  }

  /// Add a new action
  void addAction(BaseAction action){
    _actions.add(action);
  }

  /// Returns the index of the given action
  int getActonIndex(BaseAction element){
    return _actions.indexOf(element);
  }

  void clear(){
    _actions.clear();
  }

  void _init(){

  }

  _fill(){

  }
}

