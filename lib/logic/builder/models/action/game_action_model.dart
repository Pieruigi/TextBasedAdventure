import '../prompt/game_prompt_model.dart';

abstract class GameActionModel {

  /// The code has the following format: promptCode_actionIndex
  final String code;

  /// The text code
  final String textCode;

  /// Every action has at least one target to reach, so the default target is always 'target' on the json string;
  /// for example for doors the walkThroughTarget is the 'target' in the json
  final String targetCode; // key=target

  final bool hidden;

  GameActionModel({required this.code, required this.textCode, required this.targetCode, this.hidden = false});


}