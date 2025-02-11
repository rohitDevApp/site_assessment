import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';

class UserStatus extends StatefulWidget {
  final String? userId;
  final bool? status;
  const UserStatus(this.userId,this.status, {super.key});

  @override
  State<StatefulWidget> createState() => UserStatusState();
}

//userStatus
class UserStatusState extends State<UserStatus> {
  bool isActive = true;

  @override
  void initState() {
    setState(() {
      isActive=widget.status!;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isActive,
      activeColor: AppColors.mainColor,
      onChanged: (value) {
        setState(() {
          isActive = value;
          setUserStatus();
        });
      },
    );
  }

  Future<void> setUserStatus() async {
    try {
      await FireBaseApi.updateByField(FireBaseConstant.usersCollection,
          {"status": isActive}, widget.userId);
    } catch (err) {
      print(err);
    }
  }
}
