import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';

class CurrentUser {
  //Get user
  static dynamic get() async {
    try {
      var userId =
          await SharedPreferencesHelper.getPrefValue(KEYS.userId) ?? '';
      var userData = await FireBaseApi.getByDocId(
          FireBaseConstant.usersCollection, userId);
      return {
        'userId': userId,
        'role': userData.data()['Role'],
        'password': userData.data()['password'],
        'fullName': userData.data()['fullName'],
        'active': userData.data()['active'],
        'email': userData.data()['email'],
        'about': userData.data()['about'],
      };
    } catch (err) {
      print("Error Current User $err");
    }
  }

  //Remove User
  static remove() async {
    await SharedPreferencesHelper.remove(KEYS.userId);
    await SharedPreferencesHelper.remove(KEYS.fullName);
    await SharedPreferencesHelper.remove(KEYS.Role);
    await SharedPreferencesHelper.setPrefValue(KEYS.isLogin, false);
  }
}
