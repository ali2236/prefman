import 'package:prefman/src/driver.dart';
import 'package:prefman/src/drivers/in_momory_driver.dart';

///
/// The Core Class of this library.
/// Should only be used for initialization.
///
/// lower level functionality like [get],[set],[remove]
/// are used by the [Preference] class.
///
///
class PrefMan {

  static PrefManDriver _driver = PrefManInMemoryDriver();

  static PrefManDriver get driver => _driver;

  ///
  /// call with PrefManDriver Implementation before any use of Preferences.
  /// set to [PrefManInMemoryDriver] by default
  ///
  /// example:
  /// ```dart
  /// void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final driver = PrefManSharedPreferenceDriver();
  //   await driver.init();
  //   PrefMan.setDriver(driver);
  //   // ...
  // }
  /// ```
  ///
  static void setDriver(PrefManDriver driver) async {
    _driver = driver;
  }

}
