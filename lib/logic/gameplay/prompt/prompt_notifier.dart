import 'package:flutter/material.dart';

import '../../game_manager.dart';
import 'game_prompt.dart';

class PromptNotifier extends ChangeNotifier{

  static PromptNotifier? _instance;

  GamePrompt? _current;

  PromptNotifier._(){
    _instance ?? {
      GameManager.instance.registerOnGameReleasedCallback((){_current==null;}),
      _instance = this
    };
  }

  static PromptNotifier get instance { _instance ?? PromptNotifier._(); return _instance!; }

  GamePrompt get current => _current!;

  void notify(GamePrompt prompt){
    _current = prompt;
    notifyListeners();
  }
}