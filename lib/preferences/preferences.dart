import 'package:fange/preferences/preferenceskeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<SharedPreferences>? preferences;

  static Future<SharedPreferences> getPreferences() {
    return preferences ??= SharedPreferences.getInstance();
  }

  static Future<String?> getE621Username() async {
    return (await getPreferences()).getString(PreferencesKeys.e621Username);
  }

  static Future<bool> setE621Username(String username) async {
    return (await getPreferences()).setString(PreferencesKeys.e621Username, username);
  }

  static Future<String?> getE621APIKey() async {
    return (await getPreferences()).getString(PreferencesKeys.e621APIKey);
  }

  static Future<bool> setE621APIKey(String apiKey) async {
    return (await getPreferences()).setString(PreferencesKeys.e621APIKey, apiKey);
  }
}