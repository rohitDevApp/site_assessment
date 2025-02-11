import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Commons/Dashboard/drawerDto.dart';
import 'package:site_assessment/src/features/Dashboard/views/Users/Status/UserStatus.dart';

import '../../../../../constants/constants.dart';
import '../../../../../utils/user.dart';
import 'Profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<StatefulWidget> createState() => CustomerState();
}

class CustomerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? userData;
  String? userId;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    // Setup animation for loading effect
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.5, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      // Show animated loading effect while userData is null
      return Drawer(
        child: Center(
          child: FadeTransition(
            opacity: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                CustomText("Loading profile ...", 16, FontWeight.bold, AppColors.mainColor),
              ],
            ),
          ),
        ),
      );
    }
    
    bool isManager = userData?['Role'] == "Manager";

    final List<DrawerDto> arrDrawerOption = [
      DrawerDto(label: "Profile", icon: Icons.account_circle),
      if (isManager) DrawerDto(label: "Teams", icon: Icons.contact_mail),
      DrawerDto(label: "Reset Password ", icon: Icons.lock),
      DrawerDto(label: "Edit Profile ", icon: Icons.perm_contact_cal),
      DrawerDto(label: "Online", icon: Icons.add_reaction),
      DrawerDto(label: "Logo Out", icon: Icons.logout),
    ];

    //handleOptionPress
    handleOptionPress(int index) {
      //Manager Routes
      Map<int, String> managerRoutes = {
        1: ROUTES.teams,
        2: ROUTES.resetPassword,
        3: ROUTES.editProfile,
      };

      //User Routes
      Map<int, String> userRoutes = {
        1: ROUTES.resetPassword,
        2: ROUTES.editProfile,
      };

      //Select Role Routes
      Map<int, String> routes = isManager ? managerRoutes : userRoutes;
      if (routes.containsKey(index)) {
        Navigator.pushNamed(context, routes[index]!);
      }
    }

    //Handler Logout
    handlerLogout() async {
      await CurrentUser.remove();
      Navigator.pushNamed(context, ROUTES.login);
    }

    return Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Profile(userData),
            );
          } else if (index == arrDrawerOption.length - 1) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 360, right: 12, left: 12),
                  child: ElevatedButton.icon(
                    onPressed: () => handlerLogout(),
                    label: Text("Log"),
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                  ),
                )
              ],
            );
          } else {
            final option = arrDrawerOption[index];
            return SizedBox(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Row(
                  children: [
                    Icon(
                      option.icon,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () => handleOptionPress(index),
                      child: CustomText(
                          option.label, 16, FontWeight.normal, Colors.black),
                    ),
                    if (option.label == "Online") UserStatus(userId,userData?['status'])
                  ],
                ),
              ),
            );
          }
        },
        itemCount: arrDrawerOption.length,
      ),
    );
  }

  void getUserInfo() async {
    try {
      var data = await CurrentUser.get();
      var doc = await FireBaseApi.getByDocId(
          FireBaseConstant.usersCollection, data['userId']);
      setState(() {
        userData = doc.data();
        userId = doc.id;
      });
      print(userData?['status']);
    } catch (err) {
      print("$err when Drawer profile get");
    }
  }
}
