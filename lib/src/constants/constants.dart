
//Keys for SharedPreferences

import 'package:flutter/material.dart';

class KEYS {
  static String get fullName => 'fullName';
  static String get Role => 'Role';
  static String get isLogin => 'isLogin';
  static String get userId => 'userId';
  static String get managerId => 'managerId';
}

//Routes
class ROUTES {
  static String get splash =>'splash';
  static String get login =>'login';
  static String get signUp =>'signUp';
  static String get email =>'email';
  static String get otp =>'otp';
  static String get password =>'password';
  static String get dashboard =>'dashboard';
  static String get teams =>'Teams';
  static String get resetPassword =>'ResetPassword';
  static String get editProfile =>'EditProfile';

}

class DashRoutes{
  static String get home => "Home";
  static String get reports => "Reports";
  static String get tasks => "Tasks";
  static String get notification => "Notification";
  static String get setting => "Setting";
  static String get teams => "Teams";
  static String get viewReport =>'ViewReport';
  static String get addTask =>'addTask';
  static String get viewTask =>'viewTask';
}

//Colors
class AppColors{
  static const Color mainColor = Color(0xFF0077B5);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color errorColor = Colors.red;
}


