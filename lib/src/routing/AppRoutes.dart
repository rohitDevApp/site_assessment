import 'package:flutter/cupertino.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/officer/ViewTask.dart';
import '../features/Dashboard/views/Dashboard/Dashboard.dart';
import '../features/Dashboard/views/Reports/Manager/ViewReport.dart';
import '../features/Dashboard/views/Tasks/Manager/AddTaskScreen.dart';
import '../features/authentication/views/login/loginScreen.dart';
import '../features/authentication/views/splash_screen/SplashScreenWithAnimation.dart';
import 'package:site_assessment/src/features/Dashboard/views/Manager/Teams/Teams.dart';
import 'package:site_assessment/src/features/Dashboard/views/Users/profile/EditProfile.dart';
import 'package:site_assessment/src/features/Dashboard/views/Users/resetPassword/ResetPassword.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Email.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/OTP.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Password.dart';
import 'package:site_assessment/src/features/authentication/views/signup/signup.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> routes = {
    ROUTES.splash:(context)=>SplashAnimatedScreen(),
    ROUTES.login:(context)=>LoginScreen(),
    ROUTES.signUp:(context)=>SignUp(),
    ROUTES.email:(context)=>Email(),
    ROUTES.otp:(context)=>OTP(),
    ROUTES.password:(context)=>ForgotPassword(),
    ROUTES.dashboard:(context)=>Dashboard(),
    ROUTES.teams:(context)=>TeamScreen(),
    ROUTES.resetPassword:(context)=>ResetPassword(),
    ROUTES.editProfile:(context)=>EditProfile(),
    DashRoutes.viewReport:(context)=>ViewReport(),
    DashRoutes.addTask:(context)=>AddTaskScreen(),
    DashRoutes.viewTask:(context)=>ViewTask(),
  };
}