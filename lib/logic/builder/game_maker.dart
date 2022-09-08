import 'dart:convert';
import 'package:flutter/foundation.dart';
import '/logic/builder/json/json_prompt.dart';
import '/logic/builder/models/prompt/base_prompt_model.dart';
import '/logic/builder/models/prompt/common_prompt_model.dart';
import '/logic/builder/models/prompt/prompt_model_factory.dart';
import '../prompt/impl/common_prompt.dart';


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
    buildExample();

  }

  void _logicCreatePrompt(BasePromptModel model){
    if(model is CommonPromptModel){
      CommonPrompt(speech: model.descriptionLocale);
    }

  }

  ///
  /// Build example
  ///
  void buildExample(){

    ///
    /// Read all the prompts from the json file
    ///
    List<BasePromptModel> promptModelList = PromptModelFactory.fromJson(jsonDecode(json_prompt));
    for (var element in promptModelList) {debugPrint(element.toString());}
    // Build logic prompts
    for (var element in promptModelList) { _logicCreatePrompt(element); }
  }


}