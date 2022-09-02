
import 'package:textual_adventure/logic/load_and_save_system.dart';

/// Extends this class and implement getData() and init() to make your object savable.
abstract class Savable{

  Savable(){
    LoadAndSaveSystem.instance.addSaveCallback(_onSave);
  }

  String getData();

  void init(String data);

  /// We need to get data from the child class in order to save it.
  void _onSave(){
    print('saving....');
  }
}