import 'dart:collection';

import 'package:flutter/material.dart';
import 'prompts/base_prompt.dart';

/// This class manages the player prompts.
/// The current field holds the activated prompt, the one the UI is presenting to the player.
class PromptManager extends ChangeNotifier{

  static PromptManager? _instance;

  /// All the available prompts the player can go through
  List<BasePrompt> _prompts = [];

  /// The current player prompt
  BasePrompt? _current;

  /// Constructors
  PromptManager(){ _instance ??= this; }

  set current(BasePrompt value) {
    // Set the new prompt as the current one
    _current = value;
    // Notify all the listeners
    notifyListeners();
  }

  static PromptManager get instance { return _instance!; }

  UnmodifiableListView<BasePrompt> get prompts => UnmodifiableListView(_prompts);

  /// Add a new prompt
  void addPrompt(BasePrompt prompt){
    _prompts.add(prompt);
  }


  @override
  String toString() {
    // TODO: implement toString
    String ret = '';

    ret += 'Number of prompts:${prompts.length}\n';

    for (var prompt in prompts) {
      ret += '-------------------------------------------------------------------------------\n'
             'Prompt.Id:${_prompts.indexOf(prompt)}\n$prompt'
      ; }

    return ret;
  }
}