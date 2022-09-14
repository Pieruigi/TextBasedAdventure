import 'package:flutter/material.dart';

import '../../game_manager.dart';
import 'game_prompt.dart';

class PromptNotifier extends ChangeNotifier{

  static PromptNotifier? _instance;

  PromptNotifier._(){
    _instance ?? {
      _instance = this
    };
  }

  static PromptNotifier get instance { _instance ?? PromptNotifier._(); return _instance!; }

  void notify(){
    notifyListeners();
  }
}