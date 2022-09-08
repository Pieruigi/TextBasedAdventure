import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/game_manager.dart';
import 'package:textual_adventure/logic/prompt/base_prompt.dart';

class PromptNotifier extends ChangeNotifier{

  static PromptNotifier? _instance;

  BasePrompt? _current;

  PromptNotifier._(){
    _instance ?? {
      GameManager.instance.registerOnGameReleasedCallback((){_current==null;}),
      _instance = this
    };
  }

  static PromptNotifier get instance { _instance ?? PromptNotifier._(); return _instance!; }

  BasePrompt get current => _current!;

  void notify(BasePrompt prompt){
    _current = prompt;
    notifyListeners();
  }
}