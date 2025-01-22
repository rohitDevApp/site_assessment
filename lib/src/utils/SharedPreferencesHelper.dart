import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

// Initialize SharedPreferences
  static Future<void> initSharedPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //setPref Value
  static Future<bool> setPrefValue(String key, dynamic value) async {
    if (_prefs == null) {
      print("Shared Pref is not initialized");
      return false;
    }
    // Check the type of the value and set accordingly
    if (value is bool) {
      return _prefs!.setBool(key, value);
    } else if (value is String) {
      return _prefs!.setString(key, value);
    } else if (value is int) {
      return _prefs!.setInt(key, value);
    } else if (value is double) {
      return _prefs!.setDouble(key, value);
    } else {
      return false;
    }
  }

  //Get a value from SharedPreferences
  static dynamic getPrefValue(String key) {
    if (_prefs == null) {
      print("Shared Pref is not initialized");
      return null;
    }
    return _prefs!.getString(key);
  }

//Remove a value from SharedPreferences
  static Future<bool> remove(String key) async {
    if (_prefs == null) {
      print("Shared Pref is not initialized");
      return false;
    }
    return _prefs!.remove(key);
  }
}
