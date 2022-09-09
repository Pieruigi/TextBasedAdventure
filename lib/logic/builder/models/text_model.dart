class TextModel {

  /// The description key for the localization system
  final String code;

  /// Every action has at least one target to reach, so the default target is always 'target' on the json string;
  /// for example for doors the walkThroughTarget is the 'target' in the json
  final String content;


  TextModel({required this.code, required this.content});

  static List<TextModel> fromJson(Map<String, dynamic> json) {
    List<TextModel> ret = [];
    // Get the action list from the json file
    List texts = (json['texts'] as List<dynamic>);

    // Loop through each action
    for (var e in texts) {
      ret.add(TextModel(code: e['code'], content: e['content']));
    }
    return ret;
  }

}