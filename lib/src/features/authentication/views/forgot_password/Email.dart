import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';

class Email extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailState();
}

//State
class EmailState extends State<Email> {
  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //handler Forgot Password
  passwordHandler() {
    if(formKey.currentState!.validate()){
      email.clear();
      CustomSnackBar.show(context,'Sent OTP');
      Navigator.pushNamed(context, 'otp');
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
            child: Stack(
              children: [
                AuthHeader("Email"),
                // SingleChildScrollView(
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
                          InputFormField(email, 'Email'),
                          SizeBox(15),
                          NextWithIcon(passwordHandler)
                        ],
                      ),
                    ))
                // ),
              ],
            )),
          )
    );
  }
}
