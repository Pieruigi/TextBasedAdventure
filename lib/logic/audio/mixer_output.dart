import 'dart:collection';

import 'audio_mixer.dart';



class MixerOutput {
  final String _name;
  List<MixerOutput> _children = [];
  MixerOutput? _parent;
  double _volume = 1;
  bool _muted = false;


  MixerOutput(this._name, { children = const [], volume = 1, muted = false }){
    _volume = volume;
    _muted = muted;
    _children = children;
    // For each children set this has parent
    for (var element in _children) {element._parent = this;}
  }

  String get name => _name;

  double get actualVolume => _muted ? 0 : _volume;

  MixerOutput? get parent => _parent;

  set volume(double value) => _volume = value;

  /// Un/mutes this output and all its children ( recursive )
  set muted(bool value) {

    for (var output in _children) { output.muted = value; }

    _muted = value;
  }

  void addChild(MixerOutput output){
    _children.add(output);
    // Set this has parent
    output._parent = this;
  }

}
