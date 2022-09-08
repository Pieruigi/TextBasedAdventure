import 'package:textual_adventure/logic/builder/models/prompt_model.dart';

import 'action_model.dart';

class PromptModelCollection{

  final List<PromptModel>? elements;

  PromptModelCollection(this.elements);

  factory PromptModelCollection.fromJson(Map<String, dynamic> json) =>
      PromptModelCollection(
        (json['actions'] as List<dynamic>)
            .map((e) => PromptModel.fromJson(e as Map<String, dynamic>)).toList(),
      ) ;

  Map<String,dynamic> toJson() => <String,dynamic>{
    'actions' : elements
  };

  @override
  String toString() {
    // TODO: implement toString
    String ret = "[PromptModelCollection Count:${elements!.length}]";
    for (var element in elements!) {ret += '\n${element.toString()}';}
    return ret;
  }
}