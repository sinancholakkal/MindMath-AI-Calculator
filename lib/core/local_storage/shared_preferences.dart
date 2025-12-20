import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _shared;

  LocalStorage._(this._shared);

  static LocalStorage? _instance;


  static Future<LocalStorage> init() async {
    if (_instance == null) {
      final sharedPrefs = await SharedPreferences.getInstance();
      _instance = LocalStorage._(sharedPrefs);
    }
    return _instance!;
  }

  static LocalStorage get instance {
    if (_instance == null) {
      throw Exception(
        "Not initialized.",
      );
    }
    return _instance!;
  }

  bool? getBool(String key) => _shared.getBool(key);
  Future<bool> setBool(String key, bool value) => _shared.setBool(key, value);
}
