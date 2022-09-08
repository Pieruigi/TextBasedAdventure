import '../prompt/base_prompt_model.dart';

abstract class BaseActionModel {

  /// The description key for the localization system
  final String descriptionLocale;

  /// Every action has at least one target to reach, so the default target is always 'target' on the json string;
  /// for example for doors the walkThroughTarget is the 'target' in the json
  final BasePromptModel target;


  BaseActionModel({required this.descriptionLocale, required this.target});


}