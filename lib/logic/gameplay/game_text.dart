import 'package:flutter/foundation.dart';

import '../game_manager.dart';

class GameText{

  static final Map<String, GameText> _map = {};

  final String content;

  GameText({required String code, required this.content}){
    GameManager.instance.registerOnGameReleasedCallback(_clear);
    _map[code] = this;
  }


  void _clear(){
    _map.removeWhere((key, value) => value == this);
  }

  static void debug(){
    String s = '[GameTextMap element.count:${_map.length}';
    _map.forEach((key, value) { s = '$s\n[Text code:$key, content:${value.content}]'; });
    debugPrint(s);
  }
}