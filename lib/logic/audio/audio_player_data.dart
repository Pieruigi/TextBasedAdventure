import 'package:audioplayers/audioplayers.dart';
import 'package:textual_adventure/logic/audio/audioclip.dart';
import 'mixer_output.dart';

class AudioPlayerData{
  final AudioPlayer _audioPlayer;
  final MixerOutput _output;

  Audioclip? _audioclip;

  double _volume = 1; // The internal volume of the clip; the actual volume is this_volume * output_volume

  AudioPlayerData(this._audioPlayer, this._output, {Audioclip? audioclip}){
    _setAudiclip(audioclip);
    resetVolume();
  }

  MixerOutput get output => _output;

  Future<void> clear() async{
    await _audioPlayer.dispose();
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
    // Set the volume
    _audioPlayer.setVolume(actualVolume);
  }

  // Path example: String asset = 'audio/example.mp3';
  Future<void> play({required Audioclip audioclip, bool loop = false, bool forceStop = false}) async{
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
    await _audioPlayer.play(_audioclip!.assetSource);
  }

  void _setAudiclip(Audioclip? audioclip){
    _audioclip = audioclip;
    if(_audioclip != null){
      _volume = _audioclip!.volume;
    }
  }
}
