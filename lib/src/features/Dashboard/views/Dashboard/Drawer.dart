import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/features/Dashboard/views/Dashboard/drawerDto.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/user.dart';
import 'Profile.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerDto> arrDrawerOption = [
    DrawerDto(label: "Profile", icon: Icons.account_circle),
    DrawerDto(label: "Teams", icon: Icons.contact_mail),
    DrawerDto(label: "Reset Password ", icon: Icons.lock),
    DrawerDto(label: "Edit Profile ", icon: Icons.perm_contact_cal),
    DrawerDto(label: "Status ", icon: Icons.add_reaction),
    DrawerDto(label: "Logo Out", icon: Icons.logout),
  ];

  CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {

    //handleOptionPress
    handleOptionPress(int index) {
      var routeName = "";
      bool isRouting = false;
      if (index == 1) {
        routeName = ROUTES.teams;
        isRouting=true;
      }else if (index==2){
        routeName = ROUTES.resetPassword;
        isRouting=true;
      }else if (index==3){
        routeName = ROUTES.editProfile;
        isRouting=true;
      }
      if(!isRouting) return;
      Navigator.pushNamed(context, routeName);
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
              child: Profile(),
            );
          } else if (index == arrDrawerOption.length - 1) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, right: 12, left: 12),
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
                      color: Colors.purple,
                    ),
                    TextButton(
                      onPressed: () => handleOptionPress(index),
                      child: CustomText("  ${option.label}", 16,
                          FontWeight.bold, AppColors.mainColor),
                    )
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
}
