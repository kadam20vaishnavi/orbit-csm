import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a String value
  static void saveString(String key, String value) {
    _prefs?.setString(key, value);
  }

  // Save an int value
  static void saveInt(String key, int value) {
    _prefs?.setInt(key, value);
  }

  // Save a double value
  static void saveDouble(String key, double value) {
    _prefs?.setDouble(key, value);
  }

  // Save a boolean value
  static void saveBool(String key, bool value) {
    _prefs?.setBool(key, value);
  }

  // Save a list of strings
  static void saveStringList(String key, List<String> value) {
    _prefs?.setStringList(key, value);
  }

  // Retrieve a String value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Retrieve an int value
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Retrieve a double value
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // Retrieve a boolean value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Retrieve a list of strings
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  // Remove data
  static void removeData(String key) {
    _prefs?.remove(key);
  }

  // Clear all shared preferences data (e.g., on logout)
  static void clearAllData() {
    _prefs?.clear();
  }
}
