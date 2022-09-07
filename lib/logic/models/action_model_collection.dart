import 'action_model.dart';
import 'package:json_annotation/json_annotation.dart';

class ActionModelCollection{

  final List<ActionModel>? actions;

  ActionModelCollection(this.actions);

  factory ActionModelCollection.fromJson(Map<String, dynamic> json) =>
     ActionModelCollection(
       (json['actions'] as List<dynamic>)
           .map((e) => ActionModel.fromJson(e as Map<String, dynamic>)).toList(),
     ) ;

  Map<String,dynamic> toJson() => <String,dynamic>{
    'actions' : actions
  };

  @override
  String toString() {
    // TODO: implement toString
    String ret = "[ActionModelCollection Count:${actions!.length}]";
    for (var element in actions!) {ret += '\n${element.toString()}';}
    return ret;
  }
}
