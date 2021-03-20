///
/// Defines an Option in a Preference.
///
/// example use case for the [text] property:
/// if you have a list of Option<String>, you can use the [text] property to create a dropdown based on information provided by the [Preference]
/// you can access options(if there is any), by calling [Preference.options].
/// you can also see the selected option by calling [Preference.getSelectedOption()]
///
class Option<T> {
  ///
  /// can be used to name the option.
  /// it can later be useful for generating Setting Controls for Preferences.
  ///
  final String? text;

  ///
  /// the option's value.
  /// it must be the same type as the Preference Type.
  ///
  final T value;

  Option(this.value, {this.text});
}
