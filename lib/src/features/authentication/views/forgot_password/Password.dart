import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/common_widgets/input/CustomFormPassword.dart';

import '../../../../common_widgets/SnackBar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

//State
class ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //handler Forgot Password
  passwordHandler() {
    print("Value $oldPass,$newPass,$confirmPass");
    if(formKey.currentState!.validate()){
      oldPass.clear();
      newPass.clear();
      confirmPass.clear();
      CustomSnackBar.show(context,'Forgot Successfully');
      Navigator.pushNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(top: MediaQuery.of(context).size.height * 0.2,
                      left: 0,
                      right: 0,
                      child: AuthHeader("Forgotten Password")),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4,
                          left: 0,
                          right: 0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizeBox(15),
                            CustomFormPassword(newPass, 'New Password',Icons.lock_reset),
                            SizeBox(15),
                            CustomFormPassword(confirmPass, 'Confirm Password' ,Icons.check_circle_outline , confirmController:newPass),
                            SizeBox(30),
                            NextWithIcon(passwordHandler)
                          ],
                        ),
                      ))
                ],
              ),
            )),
        ),
        );
  }
}
