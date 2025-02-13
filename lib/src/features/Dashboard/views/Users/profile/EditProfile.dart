import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/SnackBar.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';

import '../../../../../common_widgets/CustomButton.dart';
import '../../../../../common_widgets/input/CustomFormInput.dart';
import '../../../../../constants/constants.dart';
import '../../../Provider/user/user_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<StatefulWidget> createState() => EditProfileState();
}

//State
class EditProfileState extends State<EditProfile> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> handleProfileUpdate() async {
    setState(() {
      isLoading=true;
    });
    Map<String, dynamic> data = {
      "fullName": userNameController.text,
      "about": aboutController.text
    };

    try {
      var userId = await SharedPreferencesHelper.getPrefValue(KEYS.userId);
      if (editProfileFormKey.currentState!.validate()) {
        await FireBaseApi.updateByField(
            FireBaseConstant.usersCollection, data, userId);
        Provider.of<UserProvider>(context, listen: false).fetchUserData();
        CustomSnackBar.show(context, "Updated Profile",position: "bottom" );
      }
    } catch (err) {
      print("Error when Edit Profile $err");
    }finally{
      setState(() {
        isLoading=false;
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false)
          .setEditProfile(emailController, userNameController, aboutController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2,
        leadingWidth: 38,
        title: CustomText(
            "Edit Profile", 18, FontWeight.bold, AppColors.mainColor),
        iconTheme: IconThemeData(color: AppColors.mainColor),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    color: AppColors.mainColor,
                    size: 62,
                  ),
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Form(
                    key: editProfileFormKey,
                    child: Column(
                      children: [
                        CustomFormInput(userNameController, "Full Name",
                            Icons.person_outline),
                        SizeBox(15),
                        CustomFormInput(
                          emailController,
                          "Email",
                          Icons.email_outlined,
                          isEnable: false,
                        ),
                        SizeBox(15),
                        CustomFormInput(
                            aboutController, "About", Icons.info_outline),
                        SizeBox(20),
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.mainColor))
                            : CustomButton("Submit", AppColors.mainColor,
                                handleProfileUpdate),
                      ],
                    ))),
          ],
        ),
      )),
    );
  }
}
