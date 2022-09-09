import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/action/base_action.dart';
import 'package:textual_adventure/logic/action/impl/common_action.dart';
import 'package:textual_adventure/logic/action/impl/door_action.dart';
import '../prompt/base_prompt.dart';
import '/logic/builder/json/json_action.dart';
import '/logic/builder/json/json_prompt.dart';
import '/logic/builder/models/prompt/base_prompt_model.dart';
import '/logic/builder/models/prompt/common_prompt_model.dart';
import '/logic/builder/models/prompt/prompt_model_factory.dart';
import '../prompt/impl/common_prompt.dart';
import 'json/locales/json_action_text_it.dart';
import 'json/locales/json_prompt_text_it.dart';
import 'models/action/action_model_factory.dart';
import 'models/action/base_action_model.dart';
import 'models/action/common_action_model.dart';
import 'models/action/door_action_model.dart';
import 'models/text_model.dart';



class GameMaker{

  static GameMaker? _instance;

  GameMaker._(){
    _instance ?? {
      _instance = this
    };
  }

  static GameMaker get instance { _instance ?? GameMaker._(); return _instance!; }

  /// This method create all the game structure ( actions, items, etc. ).
  void create(){
    _build();

    for(int i=0; i<BasePrompt.promptCount; i++){
      debugPrint(BasePrompt.getPromptAtIndex(i).toString());
    }
  }

  void _build(){
    debugPrint('Locale:$Locale');

    /// Logic maps
    /*Map<String, String> promptTextMap = {};
    Map<String, String> actionTextMap = {};*/
    Map<String, BasePrompt> promptMap = {};
    Map<String, BaseAction> actionMap = {};

    ///
    /// Load all into list from jsons
    ///
    List<TextModel> promptTextModelList = TextModel.fromJson(jsonDecode(jsonPromptText_it));
    List<TextModel>actionTextModelList = TextModel.fromJson(jsonDecode(jsonActionText_it));
    List<BasePromptModel> promptModelList = PromptModelFactory.fromJson(jsonDecode(jsonPrompt));
    List<BaseActionModel> actionModelList = ActionModelFactory.fromJson(jsonDecode(jsonAction));

    debugPrint("actionModelList.Count:${actionModelList.length}");

    ///
    /// Create logic prompts
    ///
    for (var model in promptModelList) {
      if(model is CommonPromptModel){
        promptMap[model.code] = CommonPrompt(textCode: model.code ); // Prompt and the corresponding text have the same code
      }
    }




    ///
    /// Create logic actions and add target prompts
    ///
    for (var model in actionModelList) {
      debugPrint('Processing model:${model.code}');

      // Create the action and set the targets prompts
      if(model is CommonActionModel){
        actionMap[model.code] = CommonAction(
            //textCode: actionTextModelList.firstWhere((element) => model.textCode == element.code).content,
            textCode: model.textCode,
            target: promptMap[model.targetCode],
            hidden: model.hidden.toString().toLowerCase() == 'true'
        );

      }
      if(model is DoorActionModel){

          actionMap[model.code] = DoorAction(
            textCode: model.textCode,
            walkThroughTarget: promptMap[model.targetCode],
            isLockedTarget: promptMap[(model).isLockedTargetCode],
            hasBeenUnlockedTarget: promptMap[(model).isUnlockedTargetCode],
            key: (model).keyCode,
            hidden: model.hidden.toString().toLowerCase() == 'true',
            failedToUnlockTarget: promptMap[(model).failedTargetCode],
            locked: (model).locked.toString().toLowerCase() == 'true',
          );

      }

    }
  debugPrint("ActionMap.Count:${actionMap.length}");

    ///
    /// Now we add the corresponding action group to each prompt
    ///
    promptMap.forEach((promptCode, prompt) {
      // Get all the actions belonging to the current prompt: their code is #PROMPTCODE_ACTIONINDEX
      int count = 0;
      actionMap.forEach((actionCode, action) { if(actionCode.toLowerCase().startsWith('${promptCode}_'.toLowerCase())) { count++; } });
      debugPrint("COunt:$count");
      for(int i = 0; i<count; ){
        prompt.addAction(actionMap['${promptCode}_${++i}']!);
      }

    });

  }





}