import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setValue(String key, dynamic value) async {
    if (_prefs == null) await init();
    if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  dynamic getValue(String key) {
    if (_prefs == null) return null;
    return _prefs?.get(key);
  }

  Future<void> deleteValue(String key) async {
    if (_prefs == null) await init();
    await _prefs?.remove(key);
  }
}
//use it as follows:
// SharedPrefHelper prefHelper = SharedPrefHelper();
// await prefHelper.init();

// Set value
// await prefHelper.setValue('myKey', 'myValue');

// Get value
// String value = prefHelper.getValue('myKey');

// Delete value
// await prefHelper.deleteValue('myKey');