import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:site_assessment/src/constants/constants.dart';

class Chips extends StatefulWidget {
  const Chips({super.key});

  @override
  State<StatefulWidget> createState() => ChipState();
}

//state
class ChipState extends State<Chips> {
  int tag = 0;
  List<String> options = [
    'All',
    'Today',
    'Yesterday',
  ];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      value: tag,
      choiceCheckmark: true,
      onChanged: (val) => setState(() => tag = val),
      choiceItems: C2Choice.listFrom<int, String>(
        source: options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        backgroundColor: Colors.grey,
        elevation: 2,
        overlayColor: AppColors.mainColor,
      ),
      wrapped: true,

    );
  }
}
