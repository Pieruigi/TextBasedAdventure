import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/audio/mixer_output.dart';

import 'audio_player_data.dart';

enum MixerOutputName { master , music, fx }

enum StandardPlayerType { music, fx1, fx2}

/// The audio manager is responsible for the mixer.
/// You can create as many configuration as you want, even having more than one mixer or a single mixer with more than one masters,
/// for example a master for the menu and a master for the game, it's up to you; let's say this is a common configuration
/// that should work well with most of your titles.
class AudioManager {

  static AudioManager? _instance;

  /// you can setup some default players to start with.   
  final List<AudioPlayerData> _standardPlayers = [];
  
  AudioMixer? _mixer;

  AudioManager(){
    _instance ?? {
      // Create the mixer
      _mixer = _createMixer(),

      // Init standard players
      _initStandardPlayers(),

      // Set the instance
      _instance = this,
    };
  }

  static AudioManager get instance { _instance ?? AudioManager(); return _instance!; }

  AudioPlayerData getStandardPlayer(StandardPlayerType type) {
    int index = 0;
    switch(type){
      case StandardPlayerType.music:
        index = 0;
        break;
      case StandardPlayerType.fx1:
        index = 0;
        break;
      case StandardPlayerType.fx2:
        index = 0;
        break;
    }
    return _standardPlayers[index];
  }

  /// This methods mutes the master.
  void mute(bool value){
    _mixer!.mute(value, _mixer!.getMixerOutput(MixerOutputName.master.toString()));
  }

  double getMusicVolume(){
    return _mixer!.getMixerOutput(MixerOutputName.music.toString()).volume;
  }

  double getFxVolume(){
    return _mixer!.getMixerOutput(MixerOutputName.fx.toString()).volume;
  }

  void setMasterVolume(double value){
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.master.toString()));
  }

  void setMusicVolume(double value){
    debugPrint('Changing music volume:$value');
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.music.toString()));
    debugPrint('Music volume:${_mixer!.getMixerOutput(MixerOutputName.music.toString()).volume}');
  }

  void setFxVolume(double value){
    debugPrint('Changing fx volume:$value');
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.fx.toString()));
    debugPrint('Fx volume:${_mixer!.getMixerOutput(MixerOutputName.fx.toString()).volume}');
  }

  void _setVolume(double value, MixerOutput output){
    _mixer!.setVolume(value, output);
  }


  AudioMixer _createMixer(){
    var mixer = AudioMixer();
    mixer.addMixerOutput(
        MixerOutput(MixerOutputName.master.toString()), children: [
        MixerOutput(MixerOutputName.music.toString()),
        MixerOutput(MixerOutputName.fx.toString()),
      ]
    );

    return mixer;
  }
  
  void _initStandardPlayers(){
    // Create the musics player
    _standardPlayers.add(AudioPlayerData( AudioPlayer(), _mixer!.getMixerOutput(MixerOutputName.music.toString()) ));
    _standardPlayers.add(AudioPlayerData( AudioPlayer(), _mixer!.getMixerOutput(MixerOutputName.fx.toString()) ));
    _standardPlayers.add(AudioPlayerData( AudioPlayer(), _mixer!.getMixerOutput(MixerOutputName.fx.toString()) ));
  }
}