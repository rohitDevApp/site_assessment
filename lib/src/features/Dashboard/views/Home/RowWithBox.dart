import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

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
        if (title2.isNotEmpty) DataBox(title2, data2),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.purple.shade100,
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(data.toString(), 16, FontWeight.bold, Colors.purple),
              CustomText(title, 16, FontWeight.bold, Colors.purple),
            ],
          ))),
    );
  }
}
