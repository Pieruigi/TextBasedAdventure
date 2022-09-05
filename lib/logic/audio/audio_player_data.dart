import 'package:audioplayers/audioplayers.dart';
import 'mixer_output.dart';

class AudioPlayerData{
  final AudioPlayer _audioPlayer;
  final MixerOutput _channel;

  String? _sourcePath;

  double _volume = 1; // The internal volume of the clip; the actual volume is this_volume * output_volume

  AudioPlayerData(this._audioPlayer, this._channel, {sourcePath, volume = 1}){
    _volume = volume;
    _sourcePath = sourcePath;
    resetVolume();
  }

  MixerOutput get channel => _channel;

  Future<void> clear() async{
    await _audioPlayer.dispose();
  }

  void resetVolume(){
    // _channel.actualVolume returns 0 if the channel is muted, otherwise returns _channel.volume.
    // We must multiply all the channels values until we reach the parent or the computed volume is zero
    double actualVolume = _channel.actualVolume * _volume;
    // Get parents
    MixerOutput? parent = _channel.parent;
    while(parent != null && actualVolume > 0){
      actualVolume *= parent.actualVolume;
      // Check the next parent
      parent = parent.parent;
    }
    // Set the volume
    _audioPlayer.setVolume(actualVolume);
  }

  // Path example: String asset = 'audio/example.mp3';
  Future<void> play({String? sourcePath, bool forceStop = false}) async{
    // If is already playing return
    if(_audioPlayer.state == PlayerState.playing && !forceStop){
      return;
    }

    // It's forceStop true for sure.
    if(_audioPlayer.state == PlayerState.playing){
      _audioPlayer.stop();
    }

    // If the parameter is not null we set the new source
    if(sourcePath != null){
      _sourcePath = sourcePath;
    }

    // If the source is null we throw an exception
    if(_sourcePath == null ){
      throw Exception('Audio source is null');
    }

    // Play
    await _audioPlayer.play(AssetSource(_sourcePath!));
  }
}
