import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';



class SingleReport extends StatefulWidget {
  final ReportDto report;
  const SingleReport(this.report, {super.key});

  @override
  State<StatefulWidget> createState() => SingleReportState();
}

class SingleReportState extends State<SingleReport> {
  late bool customIcon = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, DashRoutes.viewReport,arguments: widget.report);
      },
      child:  Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(widget.report.customerName, 16, FontWeight.bold,
                        Colors.black54),
                  ],
                ),
                SizeBox(9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(widget.report.siteName, 14, FontWeight.bold,
                        Colors.black54),
                    CustomText(widget.report.submitReportDate, 14,
                        FontWeight.bold, AppColors.mainColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(widget.report.location, 14, FontWeight.bold,
                        Colors.black54),
                  ],
                ),
              ],
            ),
          )),
    );

  }
}

//Row With Text
class ReportField extends StatelessWidget {
  final String value;
  const ReportField(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [CustomText(value, 16, FontWeight.normal, Colors.black)],
    );
  }
}
