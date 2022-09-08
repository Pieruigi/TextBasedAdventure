import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ActionModel{

  static const String CommonActionType = "common";
  static const String PickUpActionType = "pickUp";

  @JsonKey(required: true)
  String ref = ''; // A reference
  @JsonKey(required: true)
  String type = ''; // The action type

  String descriptionLocale = '';

  //List<TargetModel>? targets;

  ActionModel();

  //ActionModel.fromJson(Map<String, dynamic> json) : type = json['type'], descriptionLocale = json['descriptionLocale'];

  ActionModel.fromJson(Map<String, dynamic> json){
    // Add type and description
    type = json['type'];
    descriptionLocale = json['descriptionLocale'];
    ref = json['ref'];

    List<String> list = [];
    (json['targets'] as List<dynamic>).forEach((element) => print((element as Map<String,dynamic>)));

    debugPrint("type:$type");
    switch(type){
      case CommonActionType:
        debugPrint("is common action");
        fromJsonCommon(json);
        break;
      case PickUpActionType:
        debugPrint("is pickup action");
        toJsonPickUp(json);
        break;
    }

  }

  Map<String, dynamic> toJson() => {
    'type' : type,
    'descriptionLocale' : descriptionLocale
  };


  void fromJsonCommon(Map<String, dynamic> json){

  }

  void toJsonPickUp(Map<String, dynamic> json){

  }

  @override
  String toString() {
    // TODO: implement toString
    return '[ActionModel Type:$type, DescriptionLocale:$descriptionLocale]';
  }
}