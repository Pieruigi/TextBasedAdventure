import 'dart:collection';
import 'package:flutter/material.dart';
import '/logic/game_manager.dart';
import 'base_prompt.dart';


/// This class manages the player prompts.
/// The current field holds the activated prompt, the one the UI is presenting to the player.
class PromptManager extends ChangeNotifier{

  static PromptManager? _instance;

  /// All the available prompts the player can go through
  final List<BasePrompt> _prompts = [];

  /// The current prompt we are just playing
  BasePrompt? _current;

  /// Constructors
  PromptManager._(){
    _instance ?? {
      GameManager.instance.registerOnGameReleasedCallback(clear),
      _instance = this
    };
  }

  static PromptManager get instance { _instance ?? PromptManager._(); return _instance!; }

  BasePrompt get current => _current!;

  set current(BasePrompt value) {
    // Set the new prompt as the current one
    _current = value;
    // Notify all the listeners
    notifyListeners();
  }

  UnmodifiableListView<BasePrompt> get prompts => UnmodifiableListView(_prompts);

  int getPromptIndex(BasePrompt prompt){
    return _prompts.indexOf(prompt);
  }

  /// Add a new prompt
  void addPrompt(BasePrompt prompt){
    _prompts.add(prompt);
  }

  void clear(){
    _prompts.clear();
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