import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import '../../../../common_widgets/password.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

//signUp state
class SignUpState extends State<SignUp> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  IconLabel? selectedIcon;
  String roleValue = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  bool isLoading = false;
  var db = FirebaseFirestore.instance;

  //check user already Register
  Future<bool> getUserByEmail(String email) async {
    try {
      var querySnapshot =
          await db.collection("clients").where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        print("No user found with email: $email");
        return false;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return false;
    }
  }

  //SignUpHandler
  signUpHandler() async {
    setState(() {
      isFormSubmitted = true;
      isLoading = true;
    });
    if (iconController.text == '') {
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      final user = <String, dynamic>{
        "userName": userName.text,
        "email": email.text,
        "password": password.text,
        "Role": iconController.text
      };
      try {
        print("$user users");
        var userExits = await getUserByEmail(email.text);
        if (userExits) {
          CustomSnackBar.show(context, 'User Already Exits', bg: 'red');
          setState(() {
            isLoading = false;
          });
          return;
        } else {
          var res = await db.collection("clients").add(user);
          print("$res response");
          userName.clear();
          email.clear();
          password.clear();
          CustomSnackBar.show(context, 'Registered Successfully');
          Navigator.pushNamed(context, 'login');
        }
      } catch (err) {
        print("Error $err");
        CustomSnackBar.show(context, 'Not Registered', bg: 'red');
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                AuthHeader("Sign Up"),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: 20,
                      right: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DynamicMenu(iconController, (IconLabel? icon) {
                            setState(() {
                              selectedIcon = icon;
                            });
                          }, isFormSubmitted),
                          SizeBox(15),
                          InputFormField(userName, "UserName"),
                          SizeBox(15),
                          InputFormField(email, "Email"),
                          SizeBox(15),
                          Password(password, "Password"),
                          SizeBox(20),
                          isLoading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : NextWithIcon(() => signUpHandler()),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }
}
