import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';

class CurrentUser {
  //Get user
  static dynamic get() async {
    var userId = await SharedPreferencesHelper.getPrefValue(KEYS.userId) ?? '';
    var userName = await SharedPreferencesHelper.getPrefValue(KEYS.Name) ?? '';
    var role = await SharedPreferencesHelper.getPrefValue(KEYS.Role) ?? '';
    return {'userId': userId, 'role': role, 'userName': userName};
  }

  //Remove User
  static  remove() async {
    await SharedPreferencesHelper.remove(KEYS.userId);
    await SharedPreferencesHelper.remove(KEYS.Name);
    await SharedPreferencesHelper.remove(KEYS.Role);
    await SharedPreferencesHelper.setPrefValue(KEYS.isLogin, false);
  }
}
