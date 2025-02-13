import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/report/reportProvider.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';
import 'package:site_assessment/src/features/Dashboard/provider/task/taskProvider.dart';
import 'package:site_assessment/src/routing/AppRoutes.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.initSharedPref();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ROUTES.splash,
        routes: AppRoutes.routes,
      ),
    ),
  );
}





