import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grocery_app/core/errors/exceptions.dart';

/// Wrapper around SharedPreferences for type-safe local storage.
/// Registered as a singleton in InitialBinding.
class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ─── Write ────────────────────────────────────────────────────────────────

  Future<void> setString(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save string: $key');
    }
  }

  Future<void> setBool(String key, bool value) async {
    try {
      await _prefs.setBool(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save bool: $key');
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      await _prefs.setInt(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save int: $key');
    }
  }

  Future<void> setStringList(String key, List<String> value) async {
    try {
      await _prefs.setStringList(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save list: $key');
    }
  }

  /// Serializes an object to JSON and stores it.
  Future<void> setObject(String key, Map<String, dynamic> value) async {
    await setString(key, jsonEncode(value));
  }

  // ─── Read ─────────────────────────────────────────────────────────────────

  String? getString(String key) => _prefs.getString(key);

  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;

  List<String> getStringList(String key) =>
      _prefs.getStringList(key) ?? [];

  /// Reads a JSON string and decodes it to a Map.
  Map<String, dynamic>? getObject(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  bool containsKey(String key) => _prefs.containsKey(key);

  // ─── Delete ───────────────────────────────────────────────────────────────

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
