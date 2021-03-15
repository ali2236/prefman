import 'package:shared_preferences/shared_preferences.dart';

class PrefMan {
  static PrefMan? _instance;
  static SharedPreferences? _sharedPreferences;

  PrefMan._();

  factory PrefMan() {
    if (_instance == null) {
      _instance = PrefMan._();
    }
    return _instance!;
  }


  Future<void> init() async {
    if(_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  ///
  /// returns value
  ///
  T? get<T>(String key) {
    return _sharedPreferences!.get(key) as T?;
  }

  Future<bool> set(String key, dynamic value) {
    if(value is bool) return _sharedPreferences!.setBool(key, value);
    if(value is int) return _sharedPreferences!.setInt(key, value);
    if(value is String) return _sharedPreferences!.setString(key, value);
    if(value is double) return _sharedPreferences!.setDouble(key, value);
    if(value is List<String>) return _sharedPreferences!.setStringList(key, value);
    throw 'Type ${value.runtimeType} is not a supported type';
  }

  Future<bool> remove(String key) {
    return _sharedPreferences!.remove(key);
  }
}
