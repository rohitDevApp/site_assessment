import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';

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
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  var db = FirebaseFirestore.instance;

  IconLabel? selectedIcon;

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
  //handler login
  handlerLogin() async {
    print('selected Icon ${iconController.text} $isFormSubmitted');
    setState(() {
      isFormSubmitted = true;
    });
    if (loginFormKey.currentState!.validate()) {
      // var userExits = await getUserByEmail(email)
      loginFormKey.currentState?.reset();
      userName.clear();
      password.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login....'),
        ),
      );
    }
    ;
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
                            },isFormSubmitted),
                            SizeBox(15),
                            InputFormField(userName, "userName"),
                            SizeBox(15),
                            Password(password, "password"),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextButton("SignUp", "signUp"),
                                  CustomTextButton("Forgot Password", "email"),
                                ]),
                            SizeBox(10),
                            NextWithIcon(() => handlerLogin()),
                          ],
                        ))),
              ],
            ),
          )),
    );
  }
}
