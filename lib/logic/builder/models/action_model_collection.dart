import 'action_model.dart';

class ActionModelCollection{

  final List<ActionModel>? elemente;

  ActionModelCollection(this.elemente);

  factory ActionModelCollection.fromJson(Map<String, dynamic> json) =>
     ActionModelCollection(
       (json['actions'] as List<dynamic>)
           .map((e) => ActionModel.fromJson(e as Map<String, dynamic>)).toList(),
     ) ;

  Map<String,dynamic> toJson() => <String,dynamic>{
    'actions' : elemente
  };

  @override
  String toString() {
    // TODO: implement toString
    String ret = "[ActionModelCollection Count:${elemente!.length}]";
    for (var element in elemente!) {ret += '\n${element.toString()}';}
    return ret;
  }
}
