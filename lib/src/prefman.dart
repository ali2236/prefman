import 'package:prefman/prefman.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// The Core Class of this library.
/// Should only be used for initialization.
///
/// lower level functionality like [get],[set],[remove]
/// are used by the [Preference] class.
///
///
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

  ///
  /// Must be called before any use of Preferences.
  ///
  /// example:
  /// ```dart
  /// void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await PrefMan.initialize();
  //   // ...
  // }
  /// ```
  ///
  static Future<void> initialize() async {
    if (_sharedPreferences == null) {
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
    if (value is bool) return _sharedPreferences!.setBool(key, value);
    if (value is int) return _sharedPreferences!.setInt(key, value);
    if (value is String) return _sharedPreferences!.setString(key, value);
    if (value is double) return _sharedPreferences!.setDouble(key, value);
    if (value is List<String>)
      return _sharedPreferences!.setStringList(key, value);
    throw 'Type ${value.runtimeType} is not a supported type';
  }

  ///
  /// Removes the value if exists
  ///
  Future<bool> remove(String key) {
    return _sharedPreferences!.remove(key);
  }
}
