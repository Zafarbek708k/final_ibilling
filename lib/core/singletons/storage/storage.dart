import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  late final SharedPreferences _preferences;

  /// Initialize the SharedPreferences instance
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a string value
  Future<void> putString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  /// Retrieve a string value
  String? getString(String key) => _preferences.getString(key);

  /// Save an integer value
  Future<void> putInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  /// Retrieve an integer value
  int? getInt(String key) => _preferences.getInt(key);

  /// Save a boolean value
  Future<void> putBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  /// Retrieve a boolean value
  bool? getBool(String key) => _preferences.getBool(key);

  /// Save a double value
  Future<void> putDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  /// Retrieve a double value
  double? getDouble(String key) => _preferences.getDouble(key);


  /// Save a list of strings
  Future<void> putStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  /// Retrieve a list of strings
  List<String>? getStringList(String key) => _preferences.getStringList(key);


  /// Remove a value
  Future<void> delete(String key) async {
    await _preferences.remove(key);
  }

  /// Clear all stored values
  Future<void> clear() async {
    await _preferences.clear();
  }
}
