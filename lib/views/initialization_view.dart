import 'package:flutter/material.dart';
import '../logic/audio/audio_mixer.dart';
import '../logic/audio/mixer_output.dart';
import '../logic/caching/load_and_save_system.dart';
import '../logic/prefs.dart';
import '../main.dart';

class InitializationView extends StatefulWidget {
  const InitializationView({Key? key}) : super(key: key);

  @override
  State<InitializationView> createState() => _InitializationViewState();
}

class _InitializationViewState extends State<InitializationView> {

  void start() {
    debugPrint('start');
    Navigator.of(context).popAndPushNamed(mainRoute);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<Initializer>().initialize();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initialize();
      loadMainRoute();
    });
  }

  void loadMainRoute() {
    Navigator.of(context).popAndPushNamed(mainRoute);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: const Scaffold(
          body: LinearProgressIndicator()

      ),

    );
  }

}


///
/// Initialization
///
/// Add some method here if you need to initialize things on start.
  Future _initialize() async {
    // Load preferences
    await Prefs.loadAll();

    // Init save game system
    await LoadAndSaveSystem.instance.initialize();
    // Create a simple mixer
    _initializeSimpleMixer();
  }

  /// Creates a master with two children, music and fx.
  void _initializeSimpleMixer() {
    AudioMixer.instance.addMixerOutput(
        MixerOutput(MixerOutputName.master.toString(), AudioMixer.instance),
        children: [
          MixerOutput(MixerOutputName.music.toString(), AudioMixer.instance,
              outputVolume: Prefs.musicVolume),
          MixerOutput(MixerOutputName.fx.toString(), AudioMixer.instance,
              outputVolume: Prefs.fxVolume),
        ]);
  }

