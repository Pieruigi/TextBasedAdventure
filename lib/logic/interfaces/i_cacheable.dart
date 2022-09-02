abstract class ICacheable{
  /// Get data from cache
  void fromCache(String data);

  /// Set data in cache
  String toCache();
}