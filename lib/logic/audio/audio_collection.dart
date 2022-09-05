import 'audioclip.dart';

class AudioCollection{

  static final List<Audioclip> _musicClips = [];
  static final List<Audioclip> _fxClips = [];

  static void load(){
    var volumeDefault = 1;
    _musicClips.insert(0, Audioclip('audio/example.mp3', volume: 0.5));
  }

  static Audioclip getMusicClipByIndex(int index){
    return _musicClips[index];
  }

  static Audioclip getFxClipByIndex(int index){
    return _fxClips[index];
  }

}




