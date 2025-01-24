import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';

import '../../../../common_widgets/SnackBar.dart';
import '../../../../common_widgets/password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

//login State
class _LoginState extends State<LoginScreen> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  bool isLoading = false;

  IconLabel? selectedIcon;

  //check email & Password & Role
  Future<bool> checkCredential(
      String email, String password, String role) async {
    try {
      var data = await FireBaseApi.getByField(
          FireBaseConstant.usersCollection, "email", email);
      if (data.isNotEmpty) {
        for (var doc in data) {
          Map<String, dynamic> data = doc.data();
          // print("Document ID: ${doc.id}");
          print("Document Data: ${data['password']} $password $role");
          print("Document Data: ${doc.id}");
          print(
              "Document Data: ${data['password'] == password && data['Role'] == role}");
          if (data['password'] == password && data['Role'] == role) {
            try {
              await SharedPreferencesHelper.setPrefValue(
                  KEYS.fullName, data['fullName'].toString());
              await SharedPreferencesHelper.setPrefValue(
                  KEYS.Role, role.toString());
              await SharedPreferencesHelper.setPrefValue(KEYS.isLogin, true);
              await SharedPreferencesHelper.setPrefValue(KEYS.userId, doc.id);
              return true;
            } catch (err) {
              print("Error From Shared Predd $err");
            }
          } else {
            return false;
          }

          // Access the document data as a map
        }
        return false;
      } else {
        print("No user found with email: $email");
        return false;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return false;
    }
  }

  //handler login
  handlerLogin() async {
    setState(() {
      isFormSubmitted = true;
    });
    if (iconController.text == "") {
      return;
    }
    setState(() {
      isFormSubmitted = true;
      isLoading = true;
    });
    if (loginFormKey.currentState!.validate()) {
      var userExits =
          await checkCredential(email.text, password.text, iconController.text);
      if (userExits) {
        CustomSnackBar.show(context, 'Login Successfully');
        loginFormKey.currentState?.reset();
        email.clear();
        password.clear();
        Navigator.pushNamed(context, ROUTES.dashboard);
      } else {
        CustomSnackBar.show(context, 'Invalid Credential', bg: 'red');
      }
    }
    ;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Stack(
        children: [
          AuthHeader("Log In"),
          Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 20,
                  right: 20),
              child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      SizeBox(15),
                      DynamicMenu(iconController, (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      }, isFormSubmitted),
                      SizeBox(15),
                      InputFormField(email, "email"),
                      SizeBox(15),
                      Password(password, "password"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextButton("SignUp", "signUp"),
                            CustomTextButton("Forgot Password", "email"),
                          ]),
                      SizeBox(10),
                      isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.mainColor))
                          : NextWithIcon(() => handlerLogin()),
                    ],
                  ))),
        ],
      ),
    ));
  }
}
