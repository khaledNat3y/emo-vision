import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, value) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Logger.debug("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case const (String):
        await sharedPreferences.setString(key, value);
        break;
      case const (int):
        await sharedPreferences.setInt(key, value);
        break;
      case const (bool):
        await sharedPreferences.setBool(key, value);
        break;
      case const (double):
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool> getBool(String key) async {
    Logger.debug('SharedPrefHelper : getBool with key : $key');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }
  /// Gets a bool value from SharedPreferences with given [key].
  /// Returns null if the key doesn't exist.
  static Future<bool?> getBoolOrNull(String key) async {
    Logger.debug('SharedPrefHelper : getBoolOrNull with key : $key');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key); // Returns null if key doesn't exist
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    Logger.debug('SharedPrefHelper : getDouble with key : $key');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    Logger.debug('SharedPrefHelper : getInt with key : $key');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    Logger.debug('SharedPrefHelper : getString with key : $key');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    Logger.debug("FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static Future<String> getSecuredString(String key) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    Logger.debug('FlutterSecureStorage : getSecuredString with key : $key'); 
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    Logger.debug('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}