import 'package:shared_preferences/shared_preferences.dart';

final class PreferenceManager {
  PreferenceManager._internal();

  factory PreferenceManager() => singleton;
  final String _accessTokenKey = '_accessTokenKey';
  final String _onBordingSeen = '_onBordingSeen';

  static final PreferenceManager singleton = PreferenceManager._internal();

  Future<bool> setOnBoardingSeen(final bool isSeen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_onBordingSeen, isSeen);
  }

  Future<bool> getOnBoardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBordingSeen) ?? false;
  }

  Future<void> clearUserSpecificData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }

  Future<bool> setAccessToken(final String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_accessTokenKey, "$token");
  }

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey) ?? "";
  }
}
