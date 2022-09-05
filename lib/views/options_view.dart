import 'package:flutter/material.dart';
import 'package:textual_adventure/logic/audio/audio_manager.dart';
import 'package:textual_adventure/misc/constants.dart';
import 'package:textual_adventure/misc/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum OptionType { musicVolume, fxVolume }

class OptionsView extends StatefulWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  State<OptionsView> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {
  @override
  Widget build(BuildContext context) {

    Border border = Border.all(color: Colors.blueAccent, style: BorderStyle.solid, width: 3);

    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: Container(
        decoration: BoxDecoration(border: border),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            OptionSlider(optionType: OptionType.musicVolume),
            SizedBox(height: 20),
            OptionSlider(optionType: OptionType.fxVolume),
            SizedBox(height: 20),
            SizedBox(height: 20),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ButtonBack(),
          ],
        ),
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).popAndPushNamed(mainRoute),
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
          child: Center(
            child: Text(AppLocalizations.of(context)!.back, textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
          ),

        ),
      ),

    );

  }
}

class OptionSlider extends StatefulWidget {
  const OptionSlider({Key? key, required this.optionType}) : super(key: key);

  final OptionType optionType;

  @override
  State<OptionSlider> createState() => _OptionSliderState();
}

class _OptionSliderState extends State<OptionSlider> {

  double _currentValue = 0.8;

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
        AudioManager.instance.setMusicVolume(_currentValue);
        break;
      case OptionType.fxVolume:
        AudioManager.instance.setFxVolume(_currentValue);
        break;
    }
  }
}
