import 'package:audioplayers/audioplayers.dart';

class Audioclip{
  final String _sourcePath;
  double _volume = 1;

  AssetSource? _assetSource;

  Audioclip(this._sourcePath, {double volume = 1 }){
    _assetSource = AssetSource(_sourcePath);
    _volume = volume;
  }

  AssetSource get assetSource => _assetSource!;

  double get volume => _volume;
}