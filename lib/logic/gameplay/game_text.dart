import '../game_manager.dart';

class GameText{

  static final List<GameText> _list = [];

  final String content;

  GameText({required this.content}){
    GameManager.instance.registerOnGameReleasedCallback((){_list.clear();});
    _list.add(this);
  }


}