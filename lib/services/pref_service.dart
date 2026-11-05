import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._(this._prefs);

  final SharedPreferences _prefs;
  static const _kOpenCount = 'open_count';
  static const _kDarkMode = 'is_dark_mode';

  static Future<PrefService> init() async {
    return PrefService._(await SharedPreferences.getInstance());
  }

  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_kDarkMode, value);
  }

  Future<void> increaseOpenCount() async {
    await _prefs.setInt(_kOpenCount, openCount + 1);
  }
}
