import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferences _preferences;

  String? readString(String key) => _preferences.getString(key);

  Future<bool> writeString(String key, String value) {
    return _preferences.setString(key, value);
  }

  List<String> readStringList(String key) =>
      _preferences.getStringList(key) ?? <String>[];

  Future<bool> writeStringList(String key, List<String> values) {
    return _preferences.setStringList(key, values);
  }

  Map<String, dynamic>? readJson(String key) {
    final raw = _preferences.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<bool> writeJson(String key, Map<String, dynamic> value) {
    return _preferences.setString(key, jsonEncode(value));
  }
}
