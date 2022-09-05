import 'package:audioplayers/audioplayers.dart';

class Audioclip{
  final String sourcePath;
  double _volume = 1;

  Audioclip(this.sourcePath, {double volume = 1 }){
    _volume = volume;
  }

  double get volume => _volume;
}