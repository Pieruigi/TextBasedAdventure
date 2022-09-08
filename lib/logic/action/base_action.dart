import 'package:flutter/material.dart';
import '/logic/caching/cacheUtil.dart';
import '/logic/game_manager.dart';
import '/logic/interfaces/i_cacheable.dart';
import '/logic/prompt/base_prompt.dart';


/// Any instance of this class represents an action the player can do.
/// For example: open the door, take the gun, look around, speak with Peter and so on.
abstract class BaseAction with ICacheable{

  /// A list with all the actions
  static final List<BaseAction> _list = [];

  /// A short description telling the player what is going to do.
  final String _description;

  /// Is this action hidden?
  /// For example if you unlock a door this action may become hidden replaced by another than
  /// becomes visible.
  bool _hidden = false;

  /// The target prompt.
  late BasePrompt _targetPrompt;

  /// Constructor
  BaseAction({required description}) : _description = description{

    GameManager.instance.registerOnGameBuiltCallback(_init);
    GameManager.instance.registerOnGameReleasedCallback(_clear);

    _list.add(this);
  }

  String get description => _description;

  set hidden(bool value) => _hidden = value;

  ///
  /// Static methods
  ///
  static int getActionIndex(BaseAction action){
    return _list.indexOf(action);
  }

  /// Implement this method in the child class.
  /// Returns the target prompt
  @protected
  BasePrompt doActionImpl();


  ///
  /// Non static methods
  ///
  /// This method simply calls the child to perform the actual action and then updates the prompt ( the UI ).
  void doAction(){
    // Execute child method and set the target
    _targetPrompt = doActionImpl();

    // Update prompt
    _updatePrompt();
  }

  /// This method is call when the player choose this action
  void _updatePrompt(){
    // Set the current prompt
    BasePrompt.setCurrent(_targetPrompt);
  }

  void _init(){

  }

  void _clear(){
    _list.remove(this);
  }

  ///
  /// Cacher interface implementation
  ///
  /// Send value to cache
  @override
  String toCacheValue(){
    return appendCache([_hidden ? 1.toString() : 0.toString()], '');
  }
  ///
  /// Get value from cache
  ///
  @override
  void fromCacheValue(String data){
      CacheConsumingResult ccr = consumeCache(1, data);
      _hidden = int.parse(ccr.values[0]) > 0 ? true : false;
  }

  @override
  void notInCache(){

  }

  @override
  String toString() {

    String ret = '';

    ret += 'Description:$_description, Hidden:$_hidden\n';

    return ret;
  }
}