import 'package:flutter/material.dart';
import 'package:textual_adventure/misc/constants.dart';
import '/logic/game_manager.dart';
import '/logic/caching/load_and_save_system.dart';
import '/misc/themes.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    debugPrint('building main_view');
    return Scaffold(
      //backgroundColor: Colors.black87,
      backgroundColor: mainTheme.backgroundColor,
      body:
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.yellow, width: 3.0, style: BorderStyle.solid)),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 200),
            child:
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        //onTap: ()=> _play(),
                        onTap: () {Navigator.of(context).pushNamed(gameRoute);},
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                          child: Center(
                            child: Text('Play', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
                          ),


                        ),
                      ),

                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: ()=> _save(),
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                          child: Center(
                            child: Text('Save', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
                          ),


                        ),
                      ),

                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: ()=> _quit(),
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                          child: Center(
                            child: Text('Quit', textAlign: TextAlign.center,  style: mainTheme.textTheme.button),
                          ),


                        ),
                      ),

                    )
                    //Text('TextBasedAdventure'),
                  ]

            ) ,
          )
    );
  }
}



/// Shouldn't be called from here of course
void _save() async{
  await LoadAndSaveSystem.instance.save();
}

/// Quit the app
void _quit(){

}