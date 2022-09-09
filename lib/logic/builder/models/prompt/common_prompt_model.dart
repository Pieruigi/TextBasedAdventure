import '/logic/builder/models/prompt/base_prompt_model.dart';

class CommonPromptModel extends BasePromptModel{
  CommonPromptModel({required super.code});

  @override
  String toString() {
    return '[CommonPromptModel code:$code]';
  }

}