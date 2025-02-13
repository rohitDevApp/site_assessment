import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/SnackBar.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';

import '../../../../../common_widgets/CustomButton.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../common_widgets/input/CustomFormPassword.dart';
import '../../../../../constants/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<StatefulWidget> createState() => ResetState();
}

//State
class ResetState extends State<ResetPassword> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  bool isLoading = false;

  Future<void> handlePasswordUpdate() async {
    try {
      if (resetPasswordFormKey.currentState!.validate()) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        if (userProvider.userData!['password'] == oldPasswordController.text) {
          Provider.of<UserProvider>(context ,listen: false).setUserField(userProvider.userData!['userId'],
              {"password": newPasswordController.text});
          CustomSnackBar.show(context, "Password Changed Successfully",
              bg: "green", position: "bottom");
          Provider.of<UserProvider>(context, listen: false).fetchUserData();
          Navigator.pop(context);
        } else {
          CustomSnackBar.show(context, "Invalid Old Password",
              bg: "red", position: "bottom");
        }

      }
    } catch (err) {
      print("error when reset password $err");
    }finally{
      setState(() {
        isLoading=false;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2,
        leadingWidth: 38,
        title: CustomText(
            "Reset Password", 18, FontWeight.bold, AppColors.mainColor),
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
                    Icons.lock_reset,
                    color: AppColors.mainColor,
                    size: 62,
                  ),
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Form(
                    key: resetPasswordFormKey,
                    child: Column(
                      children: [
                        CustomFormPassword(
                            oldPasswordController, "Password", Icons.lock),
                        SizeBox(15),
                        CustomFormPassword(newPasswordController, "Password",
                            Icons.lock_reset),
                        SizeBox(15),
                        CustomFormPassword(
                          cnfPasswordController,
                          "Confirm Password",
                          Icons.check_circle_outline,
                          confirmController: newPasswordController,
                        ),
                        SizeBox(20),
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.mainColor))
                            : CustomButton("Reset", AppColors.mainColor,
                                handlePasswordUpdate),
                      ],
                    ))),
          ],
        ),
      )),
    );
  }
}
