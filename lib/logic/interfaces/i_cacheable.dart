abstract class ICacheable{
  /// Get data from cache
  void fromCacheValue(String data);

  /// Set data in cache
  String toCacheValue();
}