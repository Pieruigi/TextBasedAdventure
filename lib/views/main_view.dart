import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textual_adventure/misc/constants.dart';
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

                  children: const [

                     ButtonPlayGame(),
                     SizedBox(height: 20),
                     ButtonDeleteSaveGame(),

                  ]

            ) ,
          )
    );
  } // Main View

}




class ButtonPlayGame extends StatelessWidget {
  const ButtonPlayGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.watch<LoadAndSaveSystem>();

    return Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                  onTap: () {Navigator.of(context).popAndPushNamed(gameRoute);},
                  child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                  child: Center(
                    child: Text('Play', textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
                  ),

                ),
              ),

            );
  }

  Future<void> _deleteSafe(BuildContext context) async{
    bool ret = false;
    ret = (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Save Game'),
          content: Text('You are deleting all your progress, continue?'),
          actions: [
            TextButton(child: Text('Yes'), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: Text('No'), onPressed: () => Navigator.of(context).pop(false)),
          ],
        )
    )
    ) ?? false;

    print('delete: $ret');

    ret ? LoadAndSaveSystem.instance.delete() : null;
  }


}



class ButtonDeleteSaveGame extends StatefulWidget {
  const ButtonDeleteSaveGame({Key? key}) : super(key: key);

  @override
  State<ButtonDeleteSaveGame> createState() => _ButtonDeleteSaveGameState();
}

class _ButtonDeleteSaveGameState extends State<ButtonDeleteSaveGame> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("changing things");
  }

  @override
  Widget build(BuildContext context) {

    context.watch<LoadAndSaveSystem>();

    return FutureBuilder<bool>(
      future: LoadAndSaveSystem.instance.saveGameExists(),
      builder: ((context, snapshot) {
        if(snapshot.hasData){
          return       Material(
            elevation: 10,
            color: snapshot.data! ? Colors.redAccent : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () => _deleteSafe(context),
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 3, color: mainTheme.textTheme.button!.color!)),
                child: Center(
                  child: Text('Delete', textAlign: TextAlign.center,  style: mainTheme.textTheme.button,),
                ),

              ),
            ),

          );
        }
        else{
          return CircularProgressIndicator();
        }

      })

    );
    

  }

  Future<void> _deleteSafe(BuildContext context) async{
    bool ret = false;
    ret = (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Save Game'),
          content: Text('You are deleting all your progress, continue?'),
          actions: [
            TextButton(child: Text('Yes'), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: Text('No'), onPressed: () => Navigator.of(context).pop(false)),
          ],
        )
    )
    ) ?? false;

    print('delete: $ret');

    ret ? LoadAndSaveSystem.instance.delete() : null;
  }


}
