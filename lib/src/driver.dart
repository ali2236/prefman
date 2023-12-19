abstract class PrefManDriver {

  ///
  /// get stored value for key from storage
  ///
  T? get<T>(String key);

  ///
  /// set key to value in storage
  ///
  Future<bool> set(String key, dynamic value);

  ///
  /// Removes stored value for key if exists
  ///
  Future<bool> remove(String key);
}
