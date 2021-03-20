import 'package:flutter/material.dart';
import 'package:prefman/src/prefman.dart';

import 'option.dart';

///
/// if the [value] is valid returns [true]
/// if it's invalid returns [false]
///
typedef ValueValidator<T> = bool Function(T value);

///
/// You can think of this class as
/// a persistent observable variable with validation
/// can easily be used to create Setting UI using [title], [description], [options] & [getSelectedOption].
///
class Preference<T> with ChangeNotifier {
  final String key;
  final String? title, description;
  final T defaultValue;
  final List<Option<T>>? options;
  late ValueValidator<T> _validator;

  ///
  /// default [Preference] constructor
  /// you can implement your own custom [ValueValidator] for valid Preference values
  ///
  Preference({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
    required ValueValidator<T>? validator,
  }) : options = null {
    _validator = validator ?? (v) => true;
  }

  ///
  /// easy constructor for creating Preferences
  /// where the selected value must be one of the options
  ///
  Preference.options({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
    required this.options,
  }) {
    _validator = (value) {
      for (var option in options!) {
        if (option.value == value) {
          return true;
        }
      }
      return false;
    };
  }

  ///
  /// easy constructor for creating Preferences with no validators
  ///
  Preference.any({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
  }) : options = null {
    _validator = (v) => true;
  }

  ///
  /// easy factory for creating boolean options
  ///
  static Preference<bool> boolean({
    required String key,
    String? title,
    String? description,
    required bool defaultValue,
  }) {
    return Preference<bool>.options(
      key: key,
      title: title,
      description: description,
      defaultValue: defaultValue,
      options: [Option(true), Option(false)],
    );
  }

  ///
  /// easy factory for creating integer range options
  /// creates a validator for [min] <= value <= [max]
  ///
  static Preference<int> integer(
      {required String key,
      String? title,
      String? description,
      required int defaultValue,
      int? min,
      int? max}) {
    return Preference<int>(
        key: key,
        title: title,
        description: description,
        defaultValue: defaultValue,
        validator: (v) {
          if (min != null && v < min) return false;
          if (max != null && v > max) return false;
          return true;
        });
  }

  ///
  /// returns the selected value if available
  /// else it returns the default value
  ///
  T get() => PrefMan().get(key) ?? defaultValue;

  ///
  /// if the value is determined valid by the validator
  /// it gets saved and triggers a [notifyListeners]
  /// else it doesn't
  ///
  Future<void> setValue(T newValue) async {
    if (_validator(newValue)) {
      PrefMan().set(key, newValue);
      notifyListeners();
    }
  }

  ///
  /// returns the selected option if exists
  /// else it throws an exception
  ///
  /// make sure you are using a preference with options
  ///
  Option<T> getSelectedOption() {
    if (options == null) throw 'No Options found for Preference(key: $key)';
    if (options!.isEmpty)
      throw 'Preference(key: $key) doesn\'t have any options';
    final selected = get();
    return options!.firstWhere(
      (o) => o.value == selected,
      orElse: () => options!.first,
    );
  }
}
