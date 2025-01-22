import 'package:flutter/material.dart';
import 'package:site_assessment/src/utils/user.dart';

import '../../../../constants/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => SettingState();
}

//SettingState
class SettingState extends State<SettingScreen> {
  //handler Log out
  handlerLogout() async {
    await CurrentUser.remove();
    Navigator.pushNamed(context, ROUTES.login);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Scaffold()
    );
  }
}
