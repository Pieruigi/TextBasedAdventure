import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static SharedPreferences? _prefs;

  static double musicVolume = 0.8;
  static const String _musicVolumeKey = "msv";

  static double fxVolume = 0.8;
  static const String _fxVolumeKey = "fxv";

  static SharedPreferences get data => _prefs!;

  static Future loadAll() async{
    //await Future.delayed(const Duration(seconds: 10));
    //debugPrint('aaaaaaaaaaaaa');
    _prefs = await SharedPreferences.getInstance();
    if(_prefs!.getDouble(_musicVolumeKey) != null){
      musicVolume = _prefs!.getDouble(_musicVolumeKey)!;
    }

    if(_prefs!.getDouble(_fxVolumeKey) != null){
      fxVolume = _prefs!.getDouble(_fxVolumeKey)!;
    }
  }

  static Future saveAll() async{
    await _prefs!.setDouble(_musicVolumeKey, musicVolume);
    await _prefs!.setDouble(_fxVolumeKey, fxVolume);
  }



}