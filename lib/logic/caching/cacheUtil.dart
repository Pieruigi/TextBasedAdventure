import 'dart:io';

const String cacheSeparator = '|';

String appendCache(List<dynamic> params, String? cacheValue){

  cacheValue ??= '';

  if(cacheValue.isNotEmpty){
    cacheValue += cacheSeparator;
  }

  for(int i=0; i<params.length; i++) {
    cacheValue = '$cacheValue${params[i].toString()}${i<params.length-1?cacheSeparator:''}';
  }

  return cacheValue!;
}

CacheConsumingResult consumeCache(int paramCount, String cacheValue){

  // No separator ( in theory paramCount should be 1 )
  if(!cacheValue.contains(cacheValue)){
    return CacheConsumingResult([cacheValue], '');
  }

  int index = cacheValue.length;
  for(int i=0; i<paramCount; i++){
    index = cacheValue.lastIndexOf(cacheSeparator, index-1);

    // This can happen for example if you are looking for 2 params in this cache: param1|param2;
    // in this case the last iteration returns -1, so we can consume the whole cache.
    if(index < 0){
      return CacheConsumingResult(cacheValue.split(cacheSeparator), '');
    }
  }

  // We are not finished with this cache
  return CacheConsumingResult(cacheValue.substring(index+1).split(cacheSeparator), cacheValue.substring(0, index));

}

class CacheConsumingResult{
  List<String> values;
  String remainingData;

  CacheConsumingResult(this.values, this.remainingData);

  @override
  String toString() {
    String ret = 'Number of params found:${values.length}\n';
    for (var element in values) {ret += 'value:$element\n';}
    ret += 'Remaining:$remainingData';
    return ret;
  }
}