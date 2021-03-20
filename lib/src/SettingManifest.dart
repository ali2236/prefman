import 'package:prefman/src/preference.dart';
import 'prefman.dart';

///
/// enables easier grouping of Preferences and [backup] & [restore] functionality.
///
abstract class SettingManifest {
  ///
  /// How The [SettingManifest] object sees it's preferences.
  ///
  /// because we are not using Reflection or Code generation,
  /// the only way for the [SettingManifest] object to be aware of
  /// its [Preference] is by a list Provided by the programmer.
  ///
  List<Preference> get preferences;

  @Deprecated('use PrefMan.initialize() instead')
  Future<void> initialize() async {
    await PrefMan.initialize();
  }

  ///
  /// a utility function for mapping preferences to a Map.
  /// can be used to create a local/online backup of preferences.
  ///
  Map<String, dynamic> backup() {
    return {for (var pref in preferences) pref.key: pref.get()};
  }

  ///
  /// takes a {key:value} map and tries to map them to it's preferences.
  ///
  void restore(Map<String, dynamic> backup) {
    for (var pref in preferences) {
      pref.setValue(backup[pref]);
    }
  }
}
