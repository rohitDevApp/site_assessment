import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<StatefulWidget> createState() => EditProfileState();
}

//State
class EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("Edit Profile")),
    );
  }
}
