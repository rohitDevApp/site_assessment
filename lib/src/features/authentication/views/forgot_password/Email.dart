import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/common_widgets/layout/ScreenLayout.dart';
import '../../../../common_widgets/SnackBar.dart';
import '../../../../common_widgets/input/CustomFormInput.dart';
import '../../../../constants/constants.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<StatefulWidget> createState() => EmailState();
}

//State
class EmailState extends State<Email> {
  bool isHTML = false;
  bool isLoading = false;
  final TextEditingController email = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  //handler Forgot Password
  passwordHandler() {
    if (emailFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      email.clear();
      CustomSnackBar.show(context, 'Sent OTP');
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, 'otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(children: [
        Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: AuthHeader("Email")),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 0,
            right: 0,
            child: Form(
                key: emailFormKey,
                child: Column(
                  spacing: 12,
                  children: [
                    CustomFormInput(email, 'Email',Icons.email),
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.mainColor))
                        : NextWithIcon(passwordHandler),
                  ],
                )))
      ]),
    );
  }
}
