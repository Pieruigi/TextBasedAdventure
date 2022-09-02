import 'package:flutter/foundation.dart';
import 'package:textual_adventure/logic/caching/cacheUtil.dart';
import 'package:textual_adventure/logic/interfaces/i_cacheable.dart';

import '/logic/prompt/base_prompt.dart';
import '../base_action.dart';


/// Use this action if you want to walk through door.
class DoorAction extends BaseAction with ICacheable
{
  /// Door it unlocked, walk through
  final BasePrompt? walkThroughTarget;

  /// The door has been unlocked
  final BasePrompt? hasBeenUnlockedTarget;

  /// You failed to unlock the door ( maybe you are using the wrong key )
  final BasePrompt? failedToUnlockTarget;

  /// You are trying to open a locked door with no key at all
  final BasePrompt? isLockedTarget;

  /// True if the door is locked.
  bool _locked = false;

  /// If the door is locked you can set the needed key here.
  final String? key;

  /// This should be loaded from the inventory
  String? _equippedKey;

  /// Constructors
  /// The unlocked constructor needs only the walkThroughTarget prompt
  DoorAction.unlocked(super.description, this.walkThroughTarget, {this.key, this.hasBeenUnlockedTarget, this.failedToUnlockTarget, this.isLockedTarget}) : _locked = false;
  /// The locked constructor needs at least the isLockedTarget prompt
  DoorAction.locked(super.description, this.isLockedTarget, {this.key, this.walkThroughTarget, this.hasBeenUnlockedTarget, this.failedToUnlockTarget }) : _locked = true;

  /// Action implementation.
  /// We try to unlock the door if it is locked, otherwise we walk through.
  @override
  BasePrompt doActionImpl() {
    // True if we are using a key
    bool usingKey = _equippedKey != null ? true : false;
    // True is the door is locked at the moment
    bool wasLocked = _locked;

    // We always try to unlock, even if it is already unlocked
    _unlock(_equippedKey);

    // Check the result
    if(!_locked){ // Is unlocked
      if(wasLocked){ // Was locked ( so we just opened it )
        return hasBeenUnlockedTarget!;
      }
      else{ // Wasn't locked at all ( we walk )
        return walkThroughTarget!;
      }
    }
    else{ // Is locked
      if(usingKey){ // We are using the wrong key
        return failedToUnlockTarget!;
      }
      else{ // We are not even trying to unlock it
        return isLockedTarget!;
      }

    }
  }

  /// Always tries to unlock the door and returns true if the door is actually unlocked, otherwise false.
  bool _unlock(String? equippedKey){

    if(equippedKey != null && key == equippedKey){
      _locked = false;
    }

    // Returns true if the door is unlocked ( this means _locked is false, so we return !_locked )
    return !_locked;
  }

  @override
  void fromCache(String data) {
    if (kDebugMode) {
      print(data);
    }

    CacheConsumingResult res = consumeCache(1, data);
    _locked = int.parse(res.values[0]) > 0 ? true : false;
    super.fromCache(res.remainingData);
  }

  @override
  String toCache() {
    return appendCache([_locked ? 1.toString() : 0.toString()], super.toCache());
  }
}