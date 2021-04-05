import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  setToken(String value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('accessToken', value);
  }

  Future<String> getToken() async {
    sharedPreferences = await initSharedPrefrences();
    String x = sharedPreferences.getString('accessToken');
    return x;
  }


  setCountNotification(int value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setInt('countNotifi', value);
  }

  Future<int> getCountNotification() async {
    sharedPreferences = await initSharedPrefrences();
    int x = sharedPreferences.getInt('countNotifi');
    return x;
  }

    setBlocked(int value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setInt('blocked', value);
  }

  Future<int> getBlocked() async {
    sharedPreferences = await initSharedPrefrences();
    int x = sharedPreferences.getInt('blocked');
    return x;
  }

}
