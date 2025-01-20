import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';

import '../../../../common_widgets/password.dart';

class ForgotPassword extends StatefulWidget {
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
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child:Stack(
              children: [
                AuthHeader("Forgot Password"),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: 20,
                        right: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizeBox(15),
                          Password(newPass, 'New Password'),
                          SizeBox(15),
                          Password(confirmPass, 'Confirm Password' , confirmController:newPass),
                          SizeBox(30),
                          NextWithIcon(passwordHandler)
                        ],
                      ),
                    ))
              ],
            )),
          )

    );
  }
}
