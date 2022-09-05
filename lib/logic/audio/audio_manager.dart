import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/audio/mixer_output.dart';

enum MixerOutputName { master , music, fx }

/// The audio manager is responsible for the mixer.
/// You can create as many configuration as you want, even having more than one mixer or a single mixer with more than one masters,
/// for example a master for the menu and a master for the game, it's up to you; let's say this is a common configuration
/// that should work well with most of your titles.
class AudioManager {

  static AudioManager? _instance;

  AudioMixer? _mixer;

  AudioManager(){
    _instance ?? {
      // Create the mixer
      _mixer = _createMixer(),
      // Set the instance
      _instance = this
    };
  }

  AudioManager get instance { _instance ?? AudioManager(); return _instance!; }

  /// This methods mutes the master.
  void mute(bool value){
    _mixer!.mute(value, _mixer!.getMixerOutput(MixerOutputName.master.toString()));
  }

  void setMasterVolume(double value){
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.master.toString()));
  }

  void setMusicVolume(double value){
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.music.toString()));
  }

  void setFxVolume(double value){
    _setVolume(value, _mixer!.getMixerOutput(MixerOutputName.fx.toString()));
  }

  void _setVolume(double value, MixerOutput output){
    _mixer!.setVolume(value, output);
  }


  AudioMixer _createMixer(){
    var mixer = AudioMixer();
    mixer.addMixerOutput(
      MixerOutput(MixerOutputName.master.toString(), children: [
        MixerOutput(MixerOutputName.music.toString()),
        MixerOutput(MixerOutputName.fx.toString()),
      ])
    );

    return mixer;
  }
}