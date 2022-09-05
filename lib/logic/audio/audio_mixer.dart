import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'mixer_output.dart';
import 'audio_player_data.dart';

class AudioMixer{

  //static AudioMixer? _instance;

  final List<MixerOutput> _outputs = [];

  final List<AudioPlayerData> _players = [];


  //static AudioMixer get instance { _instance ?? AudioMixer(); return _instance!; }

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


  AudioPlayerData createAudioPlayerData(MixerOutput channel, {double volume = 1}){
    _players.add(AudioPlayerData(AudioPlayer(), channel));
    return _players.last;
  }

  void destroyAudioPlayerData(AudioPlayerData data){
    data.clear().whenComplete(() => _players.remove(data));
  }

  // Mute all
  void mute(bool value, MixerOutput output){
    // Mute the given output
    output.muted = value;

    // Reset audio players
    for (var element in _players) {element.resetVolume();}
  }

  // Set the volume of a specific output
  void setVolume(double value, MixerOutput output){
    // Set the channel volume
    output.volume = value;

    // Reset audio players
    for (var element in _players) {element.resetVolume();}
  }
}
