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
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;
  var db = FirebaseFirestore.instance;
  bool isLoading = false;

  IconLabel? selectedIcon;

  //check email & Password & Role
  Future<bool> checkCredential(
      String email, String password, String role) async {
    try {
      var querySnapshot =
      await db.collection("clients").where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          // print("Document ID: ${doc.id}");
          print("Document Data: ${data['password']} $password $role");
          print("Document Data: $data");
          print(
              "Document Data: ${data['password'] == password && data['Role'] == role}");
          if (data['password'] == password && data['Role'] == role) {
            try {
              print("object is not  waiting");
              // var prefs = await SharedPreferences.getInstance();
              // print("object is waiting");
              // prefs.setString("Name", data['userName'].toString());
              // prefs.setString("Role", role.toString());
              print("Object Yes ");
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
      print(userExits);
      if (userExits) {
        CustomSnackBar.show(context, 'Login Successfully');
        loginFormKey.currentState?.reset();
        email.clear();
        password.clear();
        // Navigator.pushNamed(context, 'login');
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
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withAlpha(128),
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
                            InputFormField(email, "email"),
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
                            isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white))
                                : NextWithIcon(() => handlerLogin()),
                          ],
                        ))),
              ],
            ),
          )),
    );
  }
}
