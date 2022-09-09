import '/logic/builder/models/prompt/game_prompt_model.dart';

class CommonPromptModel extends GamePromptModel{
  CommonPromptModel({required super.code, required super.textCode});

  @override
  String toString() {
    return '[CommonPromptModel code:$code]';
  }

}