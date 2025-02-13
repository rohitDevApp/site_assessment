import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/constants/constants.dart';

import '../../../Provider/user/user_provider.dart';

class UserStatus extends StatefulWidget {
  const UserStatus( {super.key});

  @override
  State<StatefulWidget> createState() => UserStatusState();
}

//userStatus
class UserStatusState extends State<UserStatus> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context,userProvider,child) =>Switch(
      value: userProvider.isActive,
      activeColor: AppColors.mainColor,
      onChanged: (value) {
        userProvider.setUserField(userProvider.userData!['userId'],{"status": true,});
      },
    ));
  }
}
