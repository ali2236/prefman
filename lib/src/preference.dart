import 'package:flutter/material.dart';
import 'package:prefman/src/prefman.dart';

import 'option.dart';

typedef ValueValidator<T> = bool Function(T value);

class Preference<T> with ChangeNotifier {
  final String key;
  final String? title, description;
  final T defaultValue;
  final List<Option<T>>? options;
  late ValueValidator<T> _validator;

  Preference({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
    required ValueValidator<T>? validator,
  }) : options = null {
    _validator = validator ?? (v) => true;
  }

  Preference.options({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
    required this.options,
  }) {
    _validator = (value) {
      for(var option in options!){
        if(option.value == value){
          return true;
        }
      }
      return false;
    };
  }

  Preference.any({
    required this.key,
    this.title,
    this.description,
    required this.defaultValue,
  }) : options = null {
    _validator = (v) => true;
  }

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

  T get() => PrefMan().get(key) ?? defaultValue;

  Future<void> setValue(T newValue) async {
    if (_validator(newValue)) {
      PrefMan().set(key, newValue);
      notifyListeners();
    }
  }

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
