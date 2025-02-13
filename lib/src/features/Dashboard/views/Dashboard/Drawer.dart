import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';
import 'package:site_assessment/src/features/Dashboard/views/Users/Status/UserStatus.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/user.dart';
import '../Users/profile/Profile.dart';
import 'drawerDto.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<StatefulWidget> createState() => CustomerState();
}

class CustomerState extends State<CustomDrawer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final userProvider = Provider.of<UserProvider>(context);

    final List<DrawerDto> arrDrawerOption = [
      DrawerDto(label: "Profile", icon: Icons.account_circle),
      if (userProvider.userData!['role']== "Manager") DrawerDto(label: "Teams", icon: Icons.contact_mail),
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
      Map<int, String> routes = (userProvider.userData!['role']== "Manager") ? managerRoutes : userRoutes;
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
              child: Profile(),
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
                    if (option.label == "Online") UserStatus()
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
