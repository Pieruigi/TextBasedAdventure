
/// This class implements the code to start a new game, to continue an existing one and so no, taking care about
/// save data etc.
class GameManager{

  /// True if the player is currently playing, otherwise false ( still in the main page or in the menu ).
  bool _inGame = false;


  void startNewGame(){
    _inGame = true;
  }

  void loadExistingGame(){
    _inGame = true;
  }

  void quitGame(){
    _inGame = false;
  }

}