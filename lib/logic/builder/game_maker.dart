import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/builder/json/json_item.dart';
import 'package:textual_adventure/logic/builder/models/action/pick_up_action_model.dart';
import 'package:textual_adventure/logic/gameplay/action/impl/pick_up_action.dart';
import 'package:textual_adventure/logic/gameplay/items/item.dart';
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
import 'models/action/game_action_model.dart';
import 'models/action/common_action_model.dart';
import 'models/action/door_action_model.dart';
import 'models/item_model.dart';
import 'models/prompt/game_prompt_model.dart';
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


  }



  void _build(){
    debugPrint('Locale:$Locale');

    ///
    /// Load from json
    ///
    /// Texts
    List<Object> tmp = TextModel.fromJson(jsonDecode(jsonPromptText_it));
    tmp.addAll(TextModel.fromJson(jsonDecode(jsonActionText_it)));
    //tmp.add(TextModel.fromJson(jsonDecode(json)))
    for (TextModel text in tmp.cast<TextModel>()) { GameText(code: text.code, content: text.content); }

    GameText.debug();

    /// Items
    tmp = ItemModel.fromJson(jsonDecode(jsonItem));
    for (ItemModel model in tmp.cast<ItemModel>()) { Item(code: model.code, nameCode: model.nameCode, textCode: model.textCode); }

    /// Prompts
    tmp = PromptModelFactory.fromJson(jsonDecode(jsonPrompt));
    for (GamePromptModel model in tmp.cast<GamePromptModel>()) {
      if(model is CommonPromptModel){
        CommonPrompt(code: model.code, textCode: model.textCode);
      }
    }

    GamePrompt.debug();

    /// Actions
    tmp = ActionModelFactory.fromJson(jsonDecode(jsonAction));
    for (GameActionModel model in tmp.cast<GameActionModel>()) {
      if(model is CommonActionModel){
        CommonAction(
            code: model.code,
          //textCode: actionTextModelList.firstWhere((element) => model.textCode == element.code).content,
            textCode:  model.textCode,
            target: GamePrompt.getPromptByCode(model.targetCode),
            hidden: model.hidden.toString().toLowerCase() == 'true'
        );

      }
      if(model is DoorActionModel){
        DoorAction(
          code: model.code,
          textCode:  model.textCode,
          walkThroughTarget: GamePrompt.getPromptByCode(model.targetCode),
          isLockedTarget: model.isLockedTargetCode != null ? GamePrompt.getPromptByCode(model.isLockedTargetCode!) : null,
          hasBeenUnlockedTarget: model.isUnlockedTargetCode != null ? GamePrompt.getPromptByCode(model.isUnlockedTargetCode!) : null,
          key: (model).keyCode,
          hidden: model.hidden.toString().toLowerCase() == 'true',
          failedToUnlockTarget: model.failedTargetCode != null ? GamePrompt.getPromptByCode(model.failedTargetCode!) : null,
          locked: (model).locked.toString().toLowerCase() == 'true',
        );
      }
      if(model is PickUpActionModel){
        PickUpAction(
          code: model.code,
          textCode: model.textCode,
          hidden: model.hidden.toString().toLowerCase() == 'true',
          item: Item.getItemByCode(model.itemCode),
          pickedUpTarget: GamePrompt.getPromptByCode(model.targetCode),
          failedTarget: model.failedTargetCode != null ? GamePrompt.getPromptByCode(model.failedTargetCode!) : null
        );
      }
    }
/*
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
            textCode:  model.textCode,
            target: promptMap[model.targetCode],
            hidden: model.hidden.toString().toLowerCase() == 'true'
        );

      }
      if(model is DoorActionModel){

          actionMap[model.code] = DoorAction(
            textCode:  model.textCode,
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
*/
  }






}