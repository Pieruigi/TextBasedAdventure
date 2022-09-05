import 'dart:collection';
import 'package:flutter/material.dart';

import 'audio_mixer.dart';

class MixerOutput {
  final String _name; // The name of the output ( for example master or music )
  final AudioMixer _mixer; // The mixer this output belongs to
  final List<MixerOutput> _children = []; // The all children
  MixerOutput? _parent; // The parent output
  double _volume = 1;
  bool _muted = false;

  final List<Function> _onVolumeChangedCallbacks = [];

  MixerOutput(this._name, this._mixer, { double outputVolume = 1.0, muted = false }){
    volume = outputVolume;
    _muted = muted;
    // For each children set this has parent
    for (var element in _children) {element._parent = this;}

  }

  String get name => _name;

  double get actualVolume => _muted ? 0 : _volume;

  set volume(double value)  {

    debugPrint('setting volume:$value');

    _volume = value;

    // Reset players audio
    _recursiveCallback(this);
  }

  MixerOutput? get parent => _parent;

  void registerOnVolumeChangedCallback(Function callback){
    _onVolumeChangedCallbacks.add(callback);
  }

  void unregisterOnVolumeChangedCallback(Function callback){
    _onVolumeChangedCallbacks.remove(callback);
  }

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

  void _recursiveCallback(MixerOutput output){

    for (var callback in output._onVolumeChangedCallbacks) {callback.call();}

    for (var child in output._children) { _recursiveCallback(child); }
  }

  @override
  String toString() {
    // TODO: implement toString
    return '[MixerOutput Name:$_name, Children.Count:${_children.length}]';
  }

}
