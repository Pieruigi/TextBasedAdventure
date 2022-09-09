import 'dart:convert';
import 'package:flutter/material.dart';
import '../gameplay/action/game_action.dart';
import '../gameplay/action/impl/common_action.dart';
import '../gameplay/action/impl/door_action.dart';
import '../gameplay/game_text.dart';
import '../gameplay/prompt/game_prompt.dart';
import '../gameplay/prompt/impl/common_prompt.dart';
import 'json/json_action.dart';
import 'json/json_prompt.dart';
import 'json/locales/json_action_text_it.dart';
import 'json/locales/json_prompt_text_it.dart';
import 'models/action/action_model_factory.dart';
import 'models/action/base_action_model.dart';
import 'models/action/common_action_model.dart';
import 'models/action/door_action_model.dart';
import 'models/prompt/base_prompt_model.dart';
import 'models/prompt/common_prompt_model.dart';
import 'models/prompt/prompt_model_factory.dart';
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

    for(int i=0; i<GamePrompt.promptCount; i++){
      debugPrint(GamePrompt.getPromptAtIndex(i).toString());
    }
  }

  void _build(){
    debugPrint('Locale:$Locale');

    /// Logic maps
    Map<String, GameText> textMap = {};
    Map<String, GamePrompt> promptMap = {};
    Map<String, GameAction> actionMap = {};

    ///
    /// Load models into corresponding lists from json files
    ///
    List<TextModel> textModelList = [];
    textModelList.addAll(TextModel.fromJson(jsonDecode(jsonPromptText_it)));
    textModelList.addAll(TextModel.fromJson(jsonDecode(jsonActionText_it)));
    List<BasePromptModel> promptModelList = PromptModelFactory.fromJson(jsonDecode(jsonPrompt));
    List<BaseActionModel> actionModelList = ActionModelFactory.fromJson(jsonDecode(jsonAction));

    debugPrint("actionModelList.Count:${actionModelList.length}");

    ///
    /// Create logic texts
    ///
    for (var value in textModelList) {
      textMap[value.code] =  GameText(content: value.content);
    }


    ///
    /// Create logic prompts
    ///
    for (var model in promptModelList) {
      if(model is CommonPromptModel){
        // Get the text id

        //promptMap[model.code] = CommonPrompt(textId: model.code ); // Prompt and the corresponding text have the same code
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
            textId:  model.textCode,
            target: promptMap[model.targetCode],
            hidden: model.hidden.toString().toLowerCase() == 'true'
        );

      }
      if(model is DoorActionModel){

          actionMap[model.code] = DoorAction(
            textId:  model.textCode,
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