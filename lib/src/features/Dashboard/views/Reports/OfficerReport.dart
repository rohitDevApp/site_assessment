import 'package:flutter/material.dart';

class OfficerReport extends StatefulWidget{
  const OfficerReport({super.key});

  @override
  State<StatefulWidget> createState() =>OfficerReportState();
}

//OfficerReport State
class OfficerReportState extends State<OfficerReport>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Officer Report"),
    );
  }
}