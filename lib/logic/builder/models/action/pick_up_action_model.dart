import 'package:textual_adventure/logic/builder/models/action/game_action_model.dart';

class PickUpActionModel extends GameActionModel{

  final String itemCode;

  final String? failedTargetCode;

  PickUpActionModel({required super.code, required super.textCode, required super.targetCode, required this.itemCode, this.failedTargetCode});

}