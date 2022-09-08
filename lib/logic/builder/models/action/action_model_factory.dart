import 'package:textual_adventure/logic/builder/models/action/common_action_model.dart';

import 'base_action_model.dart';


class ActionModelFactory{

  static const String commonActionType = "common";
  static const String pickUpActionType = "pickUp";


  static List<BaseActionModel> fromJson(Map<String, dynamic> json) {
    List<BaseActionModel> ret = [];
    // Get the action list from the json file
    List actions = (json['actions'] as List<dynamic>);

    // Loop through each action
    for (var e in actions) {
      var type = (e as Map<String, dynamic>)['type'];
      BaseActionModel model;
      switch (type) {
        case commonActionType:
          ret.add(CommonActionModel(descriptionLocale: e['descriptionLocale'], target: e['target']));
          break;
        default:
          throw Exception('No action model found to decode json');
      }
    }
    return ret;
  }



}