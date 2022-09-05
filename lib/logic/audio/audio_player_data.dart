import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/audio/audio_mixer.dart';
import 'package:textual_adventure/logic/audio/audioclip.dart';
import 'mixer_output.dart';

class AudioPlayerData{

  static final List<AudioPlayerData> _players = [];

  final AudioPlayer _audioPlayer = AudioPlayer();
  final MixerOutput _output;

  Audioclip? _audioclip;

  double _volume = 1; // The internal volume of the clip; the actual volume is this_volume * output_volume

  bool _disposed = false;

  AudioPlayerData(this._output, {Audioclip? audioclip}){

    // Register the callback
    _output.registerOnVolumeChangedCallback(resetVolume);

    // Add the object to the players lists
    _players.add(this);


    // Set the audio clip
    _setAudiclip(audioclip);

    // Init volume
    resetVolume();
  }

  MixerOutput get output => _output;

  bool get isPlaying => _audioPlayer.state == PlayerState.playing;

  bool get isDisposed => _disposed;

  Future<void> dispose() async{

    _disposed = true;

    // Stop
    _audioPlayer.stop();

    // Dispose the audio player
    await _audioPlayer.dispose();

    // Unregister the callback
    _output.unregisterOnVolumeChangedCallback(resetVolume);

    // Remove this player data from the list
    _players.remove(this);
  }

  void resetVolume(){

    // _channel.actualVolume returns 0 if the channel is muted, otherwise returns _channel.volume.
    // We must multiply all the channels values until we reach the parent or the computed volume is zero
    double actualVolume = _output.actualVolume * _volume;
    // Get parents
    MixerOutput? parent = _output.parent;
    while(parent != null && actualVolume > 0){
      actualVolume *= parent.actualVolume;
      // Check the next parent
      parent = parent.parent;
    }
    debugPrint('Setting player volume:$actualVolume');
    // Set the volume
    _audioPlayer.setVolume(actualVolume);

  }




  // Path example: String asset = 'audio/example.mp3';
  Future<void> play({required Audioclip audioclip, bool loop = false, bool forceStop = false}) async{

    _disposed ? throw Exception('You are trying to play a disposed audio player!') : null;

    // If is already playing return
    if(_audioPlayer.state == PlayerState.playing && !forceStop){
      return;
    }

    // It's forceStop true for sure.
    if(_audioPlayer.state == PlayerState.playing){
      _audioPlayer.stop();
    }

    // If the parameter is not null we set the new source
    //if(assetSource != null){
    _setAudiclip(audioclip);
    //}

    // If the source is null we throw an exception
    /*if(_assetSource == null ){
      throw Exception('Audio source is null');
    }*/

    loop ? _audioPlayer.setReleaseMode(ReleaseMode.loop) :_audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Play
    //debugPrint("AudioPlayer Volume:"${_audioPlayer.});
    resetVolume();
    await _audioPlayer.play(AssetSource(_audioclip!.sourcePath));
  }

  void _setAudiclip(Audioclip? audioclip){
    _audioclip = audioclip;
    if(_audioclip != null){
      _volume = _audioclip!.volume;
    }
  }
}
