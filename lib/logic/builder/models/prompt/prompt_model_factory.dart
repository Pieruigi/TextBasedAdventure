import 'base_prompt_model.dart';
import 'common_prompt_model.dart';

class PromptModelFactory{

  static const String commonPromptType = "common";

  static List<BasePromptModel> fromJson(Map<String, dynamic> json) {
    List<BasePromptModel> ret = [];
    // Get the action list from the json file
    List actions = (json['actions'] as List<dynamic>);

    // Loop through each action
    for (var e in actions) {
      var type = (e as Map<String, dynamic>)['type'];
      BasePromptModel model;
      switch (type) {
        case commonPromptType:
          ret.add(CommonPromptModel(code: e['code']));
          break;
        default:
          throw Exception('No action model found to decode json');
      }
    }
    return ret;
  }



}