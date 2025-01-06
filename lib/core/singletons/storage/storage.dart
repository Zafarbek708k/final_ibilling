import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static late final SharedPreferences _preferences;

  /// Initialize the SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a string value
  static Future<void> putString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  /// Retrieve a string value
  static String? getString(String key) => _preferences.getString(key);

  /// Save an integer value
  static Future<void> putInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  /// Retrieve an integer value
  static int? getInt(String key) => _preferences.getInt(key);

  /// Save a boolean value
  static Future<void> putBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  /// Retrieve a boolean value
  static bool? getBool(String key) => _preferences.getBool(key);

  /// Save a double value
  static Future<void> putDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  /// Retrieve a double value
  static double? getDouble(String key) => _preferences.getDouble(key);

  /// Save a list of strings
  static Future<void> putStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  /// Retrieve a list of strings
  static List<String>? getStringList(String key) => _preferences.getStringList(key);

  /// Remove a value
  static Future<void> delete(String key) async {
    await _preferences.remove(key);
  }

  /// Clear all stored values
  static Future<void> clear() async {
    await _preferences.clear();
  }
}
