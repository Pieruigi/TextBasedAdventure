class ItemModel{
  final String code;

  final String nameCode;

  final String textCode;

  ItemModel({required this.code, required this.nameCode, required this.textCode});

  static List<ItemModel> fromJson(Map<String, dynamic> json) {
    List<ItemModel> ret = [];
    // Get the action list from the json file
    List items = (json['items'] as List<dynamic>);

    // Loop through each action
    for (var e in items) {
      ret.add(ItemModel(code: e['code'], textCode: e['textCode'], nameCode: e['nameCode']));
    }
    return ret;
  }
}