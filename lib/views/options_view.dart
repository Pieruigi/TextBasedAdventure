import 'package:flutter/material.dart';
import 'misc/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../logic/prefs.dart';
import '../main.dart';
import 'commons.dart';

class OptionsView extends StatefulWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  State<OptionsView> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(

       onWillPop: () { Prefs.saveAll(); Navigator.of(context).popAndPushNamed(mainRoute); return Future<bool>.value(false); },
       child: Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: const OptionBody(),
    ),

    );
  }
}



///
/// Custom widgets
///

class OptionBody extends StatelessWidget {
  const OptionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Border border = Border.all(color: Colors.blueAccent, style: BorderStyle.solid, width: 3);

    return Container(
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
        onTap: () => { () => Prefs.saveAll(), Navigator.of(context).popAndPushNamed(mainRoute) },
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


