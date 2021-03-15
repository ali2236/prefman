import 'package:prefman/src/preference.dart';
import 'package:prefman/src/prefman.dart';

abstract class SettingManifest {
  List<Preference> get preferences;

  Future<void> initialize() async {
    await PrefMan().init();
  }

  Map<String, dynamic> backup() {
    return {
      for (var pref in preferences) pref.key: pref.get(),
    };
  }

  void restore(Map<String, dynamic> backup) {
    for (var pref in preferences) {
      pref.setValue(backup[pref]);
    }
  }
}
