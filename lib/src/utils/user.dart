import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';

class CurrentUser {
  //Get user
  static dynamic get() async {
    var userId = await SharedPreferencesHelper.getPrefValue(KEYS.userId) ?? '';
    var fullName = await SharedPreferencesHelper.getPrefValue(KEYS.fullName) ?? '';
    var role = await SharedPreferencesHelper.getPrefValue(KEYS.Role) ?? '';
    var managerId = await SharedPreferencesHelper.getPrefValue(KEYS.managerId) ?? '';
    return {'userId': userId, 'role': role, 'fullName': fullName , 'managerId': managerId};
  }

  //Remove User
  static  remove() async {
    await SharedPreferencesHelper.remove(KEYS.userId);
    await SharedPreferencesHelper.remove(KEYS.fullName);
    await SharedPreferencesHelper.remove(KEYS.Role);
    await SharedPreferencesHelper.setPrefValue(KEYS.isLogin, false);
  }
}
