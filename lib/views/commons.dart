import 'package:flutter/material.dart';
import '../logic/audio/audio_mixer.dart';
import '../logic/prefs.dart';

enum OptionType { musicVolume, fxVolume }

///
/// A message box to choose between actions
///
Future<bool> messageBox({ required BuildContext context, required String title, required String content, required String yesText, required String noText, required Function yesFunc, required Function noFunc }) async{
  bool result = (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: () =>  Navigator.of(context).pop(true), child: Text(yesText)),
        TextButton(onPressed: () =>  Navigator.of(context).pop(false), child: Text(noText)),
      ],

    ),
  )
  ) ?? false;

  result ? yesFunc.call() : noFunc.call();
  return false;
}

///
/// Option slider
///
class OptionSlider extends StatefulWidget {
  const OptionSlider({Key? key, required this.optionType}) : super(key: key);

  final OptionType optionType;

  @override
  State<OptionSlider> createState() => _OptionSliderState();
}

class _OptionSliderState extends State<OptionSlider> {

  double _currentValue = 0.8;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentValue = (widget.optionType == OptionType.musicVolume ? Prefs.musicVolume : Prefs.fxVolume);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _currentValue,
        min: 0,
        max: 1,
        //divisions: 10,
        onChanged: _onChanged
    );
  }

  void _onChanged(double value){
    setState(() {
      _currentValue = value;
      _setOption(widget.optionType);
    });
  }

  void _setOption(OptionType optionType){
    switch(optionType){
      case OptionType.musicVolume:
        AudioMixer.instance.getMixerOutput(MixerOutputName.music.toString()).volume = _currentValue;
        Prefs.musicVolume = _currentValue;
        break;
      case OptionType.fxVolume:
        AudioMixer.instance.getMixerOutput(MixerOutputName.fx.toString()).volume = _currentValue;
        Prefs.fxVolume = _currentValue;
        break;
    }
  }
}

