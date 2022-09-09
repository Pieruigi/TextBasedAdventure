import 'package:textual_adventure/logic/builder/models/action/common_action_model.dart';

import 'base_action_model.dart';
import 'door_action_model.dart';


class ActionModelFactory{

  static const String commonActionType = "common";
  static const String pickUpActionType = "pickUp";
  static const String doorActionType = "door";


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
          ret.add(CommonActionModel(code: e['code'], textCode: e['textCode'], targetCode: e['target'], hidden: e['hidden']?.toString().toLowerCase() == 'true'   ));
          break;
        case doorActionType:
          ret.add(DoorActionModel(
              code: e['code'],
              textCode: e['textCode'],
              hidden: e['hidden']?.toString().toLowerCase() == 'true',
              targetCode: e['target'],
              isUnlockedTargetCode: e['uTarget'],
              failedTargetCode: e['fTarget'],
              isLockedTargetCode: e['lTarget'],
              keyCode: e['keyCode'],
              locked: e['locked']
          ));
          break;
        default:
          throw Exception('No action model found to decode json');
      }
    }
    return ret;
  }



}