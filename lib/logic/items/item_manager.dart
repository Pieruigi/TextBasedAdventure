import '../game_manager.dart';
import 'item.dart';

/// It creates and stores all the items in the game into a list.
/// It's a singleton.
class ItemManager{

  /// For singleton
  static ItemManager? _instance;

  final List<Item> _items = [];

  /// Constructor
  ItemManager(){
    _instance ?? {
      GameManager.instance.registerOnGameStartCallback(clear),
      GameManager.instance.registerOnGameStopCallback(clear),
      _instance = this
    };
  }

  static ItemManager get instance {
    _instance ?? ItemManager();

    return _instance!;
  }

  /// Add a new item
  void addItem(Item item){
    _items.add(item);
  }


  int getItemIndex(Item element){
    return _items.indexOf(element);
  }

  void clear(){
    _items.clear();
  }


}

/// This string contains all the items in order to initialize the item list.
/// String format: 'type|name|description|[specific_data]'
///   - type: weapon|medkit|ammo|etc...
///   - specific_data: it depends on the type ( for example a weapon has the delivering damage )
String itemStr =
    'weapon|gun|A 9mm. handgun.|100|25\n'
    'weapon|rifle|A rifle.|80|100\n';
