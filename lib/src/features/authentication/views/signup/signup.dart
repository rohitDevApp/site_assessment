import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import '../../../../common_widgets/SnackBar.dart';
import '../../../../common_widgets/input/CustomFormInput.dart';
import '../../../../common_widgets/input/CustomFormPassword.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => SignUpState();
}

//signUp state
class SignUpState extends State<SignUp> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  IconLabel? selectedIcon;
  String roleValue = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  bool isLoading = false;
  var db = FirebaseFirestore.instance;


  //check user already Register
  Future<bool> getUserByEmail(String email) async {
    try {
      var querySnapshot = await db
          .collection(FireBaseConstant.usersCollection)
          .where("email", isEqualTo: email)
          .get();

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
        "fullName": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "Role": iconController.text,
        "about": aboutController.text,
        "active":true,
      };
      setState(() {
        isLoading = false;
      });

      try {
        var userExits = await getUserByEmail(emailController.text);
        if (userExits) {
          CustomSnackBar.show(context, 'User Already Exits', bg: 'red');
          setState(() {
            isLoading = false;
          });
          return;
        } else {
          var res =
              await FireBaseApi.insert(FireBaseConstant.usersCollection, user);
          userNameController.clear();
          emailController.clear();
          passwordController.clear();
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
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Positioned(top: MediaQuery.of(context).size.height * 0.1,
                        left: 0,
                        right: 0,
                        child: AuthHeader("Sign Up")),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.25,
                        left: 0,
                        right: 0,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              spacing: 12,
                              children: [
                                DynamicMenu(iconController, (IconLabel? icon) {
                                  setState(() {
                                    selectedIcon = icon;
                                  });
                                }, isFormSubmitted),
                                CustomFormInput(userNameController, "Full Name",Icons.person_outline),
                                CustomFormInput(emailController, "Email",Icons.email_outlined),
                                CustomFormPassword(passwordController, "Password",Icons.lock_outline),
                                CustomFormInput(aboutController, "About",Icons.info_outline),
                                isLoading
                                    ? CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.mainColor),
                                      )
                                    : NextWithIcon(() => signUpHandler()),
                              ],
                            ))),
                  ],
                ))));

  }
}
