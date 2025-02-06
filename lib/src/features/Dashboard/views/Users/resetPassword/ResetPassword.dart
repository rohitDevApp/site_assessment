import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../../../../../common_widgets/CustomButton.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../common_widgets/password.dart';
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
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  bool isLoading = false;

  Future<void> handlerResetPassword() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText("Reset Password", 18, FontWeight.bold, Colors.blue),),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Form(
                    key: loginFormKey,
                    child: Column(
                      spacing: 12,
                      children: [
                        InputFormField(email, "Old  Password"),
                        Password(password, "New Password"),
                        Password(password, "Confirm Password"),
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.mainColor))
                            : CustomButton("Reset", ROUTES.dashboard,AppColors.mainColor),
                      ],
                    ))),
          ],
        ),
      )),
    );
  }
}
