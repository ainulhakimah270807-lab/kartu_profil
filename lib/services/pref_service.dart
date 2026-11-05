import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._(this._prefs);

  final SharedPreferences _prefs;
  static const _kOpenCount = 'open_count';

  static Future<PrefService> init() async {
    return PrefService._(await SharedPreferences.getInstance());
  }

  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  Future<void> increaseOpenCount() async {
    await _prefs.setInt(_kOpenCount, openCount + 1);
  }
}
