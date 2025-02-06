import 'package:flutter/cupertino.dart';

import '../../../../../constants/constants.dart';

class ReportBackground extends StatelessWidget {
  const ReportBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          color: AppColors.mainColor,
        ));
  }
}
