import 'package:textual_adventure/logic/prompt/impl/common_prompt.dart';

class PromptModel{

  static const String CommonPromptType = "common";

  String type = '';
  String descriptionLocale = '';

  PromptModel();

  PromptModel.fromJson(Map<String, dynamic> json){
    // Add type and description
    type = json['type'];
    descriptionLocale = json['descriptionLocale'];

/*    List<String> list = [];
    (json['targets'] as List<dynamic>).forEach((element) => print((element as Map<String,dynamic>)));*/


    switch(type){
      case CommonPromptType:
        fromJsonCommon(json);
        break;


    }



  }

  Map<String, dynamic> toJson() => {
    'type' : type,
    'descriptionLocale' : descriptionLocale
  };

  void fromJsonCommon(Map<String, dynamic> json){
    descriptionLocale = json['descriptionLocale'];

  }

  void toJsonPickUp(Map<String, dynamic> json){

  }

  @override
  String toString() {
    // TODO: implement toString
    return '[PromptModel Type:$type, DescriptionLocale:$descriptionLocale]';
  }
}