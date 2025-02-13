import 'package:flutter/material.dart';
import '../../../../api/firebaseApi.dart';
import '../../../../constants/firebase.dart';
import '../../../../utils/user.dart';

class UserProvider with ChangeNotifier {
  bool _isActive = false;
  bool get isActive => _isActive;

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  //fetchUserData
  Future<void> fetchUserData() async {
    try {
      var getData = await CurrentUser.get();
      if (getData != null && getData.isNotEmpty) {
        if (_userData == null || getData.toString() != _userData.toString()) {
          _userData = getData;
          _isActive = getData['status'] ?? false;
          notifyListeners();
        }
      }
    } catch (err) {
      debugPrint("Error fetching user data: $err");
    }
  }

  //setStatus of user
  Future<void> setUserField(String userId, dynamic fields) async {
    try {
      _isActive = !_isActive;
      Map<String, dynamic> data = {};

      //Add Status
      if(fields.containsKey('status')){
          data['status'] = _isActive;
      }

      // Avoid overwriting 'status' again
      fields.forEach((key, value) {
        if (key != 'status') {
          data[key] = value;
        }
      });

      await FireBaseApi.updateByField(
          FireBaseConstant.usersCollection, data, userId);
    } catch (err) {
      print(err);
    } finally {
      notifyListeners();
    }
  }

//setEditProfile
  void setEditProfile(TextEditingController email,
      TextEditingController fullName, TextEditingController about) {
    email.text = userData!['email'];
    fullName.text = userData!['fullName'];
    about.text = userData!['about'];
  }
}
