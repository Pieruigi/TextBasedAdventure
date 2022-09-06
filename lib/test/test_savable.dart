import '/logic/caching/cacher.dart';
import 'package:textual_adventure/logic/interfaces/i_cacheable.dart';

class TestSavable extends TestBaseSavable with ICacheable{

  TestSavable(super.name){
    //Savable(saveCode!, toData, fromData);

  }

  String toData(){
    return '12|334|askas';
  }

  @override
  void fromCacheValue(String data) {
    //print('fromCache:$data');
  }

  @override
  String toCacheValue() {
    // TODO: implement toCache
    return '0x112|berry|12.4';
  }



}


abstract class TestBaseSavable{
  final String _name;

  TestBaseSavable(this._name);
}