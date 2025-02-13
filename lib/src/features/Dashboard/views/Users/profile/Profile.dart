import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';

import '../../../../../common_widgets/RowText.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../constants/constants.dart';
import '../../../../../utils/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => ProfileState();
}

//Profile State
class ProfileState extends State<Profile> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    // Future.microtask((){
    //   Provider.of<UserProvider>(context,listen: false).fetchUserData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SizedBox(
        child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Container(
        color: AppColors.mainColor,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            SizeBox(22),
            RowText(userProvider.userData?['fullName'] ?? "NA", 18, FontWeight.bold, Colors.white),
            RowText(userProvider.userData?['email'] ?? "NA", 14, FontWeight.bold, Colors.white),
            RowText(userProvider.userData?['about'] ?? "NA", 14, FontWeight.bold, Colors.white),
            SizeBox(22),
          ],
        ),
      ),
    ));
  }

  Future<void> getUserData() async {
    try {
      var getData = await CurrentUser.get();
      if (!mounted) return;
      if (userData == null || getData.toString() != userData.toString()) {
        setState(() {
          userData = getData;
        });
      }
    } catch (err) {
      print("$err when Drawer profile get");
    }
  }
}
