import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';

import 'CommentBox.dart';

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
    return Padding(
        padding: EdgeInsets.all(1),
        child: Card(
            elevation: 4,
            color: AppColors.mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  "${widget.report.customerName} Report ",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  customIcon
                      ? Icons.arrow_drop_down_circle
                      : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                children: <Widget>[
                  Divider(height: 3, color: Colors.white),
                  Container(
                    color: Colors.white,
                    child:  Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ReportField(
                              "Customer Name : ${widget.report.customerName}"),
                          ReportField("Site Name : ${widget.report.siteName}"),
                          ReportField("Location : ${widget.report.location}"),
                          ReportField(
                              "Date of Visit: ${widget.report.dateOfVisit}"),
                          ReportField(
                              "Pump Capacity : ${widget.report.pumpCapacity} m³/h "),
                          ReportField(
                              "Pump Efficiency :${widget.report.pumpEfficiency} %"),
                          ReportField(
                              "Liquid Temperature :${widget.report.liquidTemperature} °C"),
                          ReportField(
                              "Electrical Power Consumption: ${widget.report.electricalPowerConsumption} Kw"),
                          ReportField(
                              "Installation Date : ${widget.report.installationDate}"),
                          ReportField(
                              "Last Service Date : ${widget.report.lastServiceDate}"),
                          CommentBox(),
                        ],
                      ),
                    ),
                  )

                ],
                onExpansionChanged: (bool expanded) {
                  setState(() => customIcon = expanded);
                },
              ),
            )));
  }
}

//Row With Text
class ReportField extends StatelessWidget {
  final String value;
  const ReportField(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(value, 16, FontWeight.normal, Colors.black)
      ],
    );
  }
}



