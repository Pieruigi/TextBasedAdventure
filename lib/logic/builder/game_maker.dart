import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:textual_adventure/logic/action/impl/common_action.dart';
import 'package:textual_adventure/logic/builder/json/json_prompt.dart';
import 'package:textual_adventure/logic/builder/models/prompt_model.dart';
import 'package:textual_adventure/logic/builder/models/prompt_model_collection.dart';
import '../action/impl/pick_up_action.dart';
import '../prompt/base_prompt.dart';
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

  void buildExample(){
    CommonPrompt toRemove = CommonPrompt(speech: 'no exception');

    ///
    /// Read all the prompts from the json file
    ///
    PromptModelCollection promptModelCollection = PromptModelCollection.fromJson(jsonDecode(json_prompt));
    debugPrint(promptModelCollection.toString());

  }


}