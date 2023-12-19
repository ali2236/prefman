import 'package:prefman/prefman.dart';

class PrefManInMemoryDriver extends PrefManDriver {
  final _store = <String, dynamic>{};

  @override
  T? get<T>(String key) {
    return _store[key];
  }

  @override
  Future<bool> remove(String key) async {
    return _store.remove(key) != null;
  }

  @override
  Future<bool> set(String key, value) async {
    _store.addAll({key: value});
    return true;
  }
}
