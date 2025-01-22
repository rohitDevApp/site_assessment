import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/features/Dashboard/views/Dashboard/Dashboard.dart';
import 'package:site_assessment/src/features/Dashboard/views/Teams/Teams.dart';
import 'package:site_assessment/src/features/Dashboard/views/profile/EditProfile.dart';
import 'package:site_assessment/src/features/Dashboard/views/resetPassword/ResetPassword.dart';
import 'package:site_assessment/src/features/authentication/views/login/login.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Email.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/OTP.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Password.dart';
import 'package:site_assessment/src/features/authentication/views/signup/signup.dart';
import 'package:site_assessment/src/features/authentication/views/splash_screen/splash_screen.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.initSharedPref();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: ROUTES.splash,
    routes: {
      ROUTES.splash:(context)=>SplashScreen(),
      ROUTES.login:(context)=>LoginScreen(),
      ROUTES.signUp:(context)=>SignUp(),
      ROUTES.email:(context)=>Email(),
      ROUTES.otp:(context)=>OTP(),
      ROUTES.password:(context)=>ForgotPassword(),
      ROUTES.dashboard:(context)=>Dashboard(),
      ROUTES.teams:(context)=>TeamScreen(),
      ROUTES.resetPassword:(context)=>ResetPassword(),
      ROUTES.editProfile:(context)=>EditProfile(),
    },
  ));
}





