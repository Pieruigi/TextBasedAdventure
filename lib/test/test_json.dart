
class TestJson{

  static String json1 = '{ "type" : "common", "descriptionLocale" : "openDoor" }';

  static String json2 =
      '{"actions" : [ '
                    '{ "type" : "common", "descriptionLocale" : "openDoor" },'
                    '{ "type" : "pickUp", "descriptionLocale" : "pickUp" }'
                   ']}';

  static String json3 =
      '{"actions" : [ '
      '{ "type" : "common", "descriptionLocale" : "openDoor", "targets" : [ { "target" : "0x0012" } ] },'
      '{ "type" : "pickUp", "descriptionLocale" : "pickUp", "targets" : [ { "target" : "0x2001", "target" : "0x0501" } ] }'
      ']}';

/*  static void load1(){
    ActionModel actionModel = ActionModel.fromJson(jsonDecode(json1));
    debugPrint(actionModel.toString());
  }

  static void load2(){
    ActionModelCollection collection = ActionModelCollection.fromJson(jsonDecode(json2));
    debugPrint(collection.toString());
    String json = jsonEncode(collection.toJson());
    debugPrint(json.toString());
  }

  static void load3(){
    ActionModelCollection collection = ActionModelCollection.fromJson(jsonDecode(json3));
    debugPrint(collection.toString());
    String json = jsonEncode(collection.toJson());
    debugPrint(json.toString());
  }*/
}