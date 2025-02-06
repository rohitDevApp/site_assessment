
import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

class BackWithHeader extends StatefulWidget {
  const BackWithHeader({super.key});

  @override
  State<StatefulWidget> createState() => BackHeaderState();
}

//State
class BackHeaderState extends State<BackWithHeader> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      child: Row(
        spacing: 10,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.black87, size: 32,),),
          CustomText("Reports", 20, FontWeight.bold, Colors.black87)
        ],
      ),
    );
  }
}
