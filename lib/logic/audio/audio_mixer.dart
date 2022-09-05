import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'mixer_output.dart';
import '../prefs.dart';

enum MixerOutputName { master , music, fx }

class AudioMixer{

  static AudioMixer? _instance;

  final List<MixerOutput> _outputs = [];

  AudioMixer(){
    _instance ?? {
      _instance = this
    };

  }

  static AudioMixer get instance { _instance ?? AudioMixer(); return _instance!; }

  void addMixerOutput(MixerOutput output, {List<MixerOutput> children = const []}){
    debugPrint("Adding new mixer output:$output");
    _outputs.add(output);
    debugPrint('Children.Count:${children.length}');
    // Eventually add children
    for (var value in children) {
      debugPrint('Child:$value');
      if(!_outputs.contains(value)){
        _outputs.add(value);
      }
      output.addChild(value);
    }

    debugPrint('Number of actual outputs:${_outputs.length}');
  }

  MixerOutput getMixerOutput(String name){
    return _outputs.firstWhere((element) => element.name == name);
  }


}

