import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';

class ShowModal extends StatefulWidget {
  const ShowModal({super.key});

  @override
  State<StatefulWidget> createState() => ModalState();
}

//modal State
class ModalState extends State<ShowModal> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
