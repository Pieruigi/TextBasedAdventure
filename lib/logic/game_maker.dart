import 'package:textual_adventure/logic/action/impl/common_action.dart';

import 'caching/cacher.dart';
import 'prompt/impl/common_prompt.dart';
import 'action/impl/door_action.dart';


class GameMaker{

  static GameMaker? _instance;

  GameMaker._(){
    _instance ?? {
      _instance = this
    };
  }

  static GameMaker get instance { _instance ?? GameMaker._(); return _instance!; }

  /// This method create all the game structure ( actions, items, etc. ).
  void create(){

    /// Part 1
    ///
    CommonPrompt p1 = CommonPrompt('Sei in una stanza, puoi andare a destra e avanti.');
    CommonPrompt p2 = CommonPrompt('Sei andato avanti e hai trovato una porta.');
    CommonPrompt p3 = CommonPrompt('Sei andato a destra e ti trovi davanti a una scrivania.');

    p1.addAction(CommonAction('Vai avanti', p2));
    p1.addAction(CommonAction('Vai a destra', p3));

    p2.addAction(CommonAction('Torni al centro della stanza', p1));
    p3.addAction(CommonAction('Torni al centro della stanza', p1));

    /*
    p2.addAction(Cacher(DoorAction.locked('Provi ad aprire la porta', )))

    p = CommonPrompt('Sei andato avanti e hai trovato una porta');
    Cacher(DoorAction.locked('Provi ad aprire la porta', p));
    CommonAction('Vai indietro', p);



    Cacher(DoorAction.unlocked('A simple door unlocked', CommonPrompt('You came from the door')));
    Cacher(DoorAction.locked('A simple door locked', CommonPrompt('This door is locked')));*/
  }
}