import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/RowText.dart';

class RowWithBox extends StatelessWidget {
  final String title1;
  final int data1;
  final String title2;
  final int data2;

  //Constructor
  const RowWithBox(this.title1, this.data1, this.title2, this.data2,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DataBox(title1, data1),
        Visibility(
          visible: title2.isNotEmpty,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: DataBox(title2, data2),
        ),
      ],
    );
  }
}

//Data Box
class DataBox extends StatelessWidget {
  final String title;
  final int data;
  //Constructor
  const DataBox(this.title, this.data, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 100,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFF0F8FF),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: 3,
                children: [
                  // Icon(Icons.account_balance_wallet),
                  CustomText(title, 16, FontWeight.normal, Colors.black)
                ],
              ),
              RowText(data.toString(), 20, FontWeight.bold, Colors.black),
            ],
          ))),
    );
  }
}
