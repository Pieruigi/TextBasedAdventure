import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioManager{

  static AudioManager? _instance;

  final AudioPlayer _player = AudioPlayer();

  AudioManager(){
    _instance ?? {
      _instance = this,
    };
  }

  static AudioManager get instance { _instance ?? AudioManager(); return _instance!; }


  Future<void> test() async{
    String asset = 'audio/example.mp3';


    await _player.play(AssetSource(asset));
  }
}