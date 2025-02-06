import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/routing/AppRoutes.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.initSharedPref();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: ROUTES.splash,
    routes: AppRoutes.routes,
  ));

}





