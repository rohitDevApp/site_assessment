import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_assessment/firebase_options.dart';
import 'package:site_assessment/src/features/authentication/views/login/login.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Email.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/OTP.dart';
import 'package:site_assessment/src/features/authentication/views/forgot_password/Password.dart';
import 'package:site_assessment/src/features/authentication/views/signup/signup.dart';
import 'package:site_assessment/src/features/authentication/views/splash_screen/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      'splash':(context)=>SplashScreen(),
      'login':(context)=>LoginScreen(),
      'signUp':(context)=>SignUp(),
      'email':(context)=>Email(),
      'otp':(context)=>OTP(),
      'password':(context)=>ForgotPassword(),
    },
  ));
}





