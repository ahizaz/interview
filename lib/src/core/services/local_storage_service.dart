import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();
  static const String _hasSeenSplashKey = 'has_seen_splash';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get hasSeenSplash => _prefs.getBool(_hasSeenSplashKey) ?? false;

  Future<void> setHasSeenSplash() async {
    await _prefs.setBool(_hasSeenSplashKey, true);
  }
}
