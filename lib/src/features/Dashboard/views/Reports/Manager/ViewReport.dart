import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';

import 'comment/CommentBox.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportDto report =
        ModalRoute.of(context)!.settings.arguments as ReportDto;
    print(report.reportId);
    return Scaffold(
      appBar: AppBar(
        title: CustomText("View Report", 18, FontWeight.bold, Colors.black54),
        backgroundColor: AppColors.lightBlue,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 15, right: 12, left: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: CustomText(report.customerName, 24,
                            FontWeight.bold, AppColors.mainColor),
                      ),
                    ),
                    ReportField("Site Name ", report.siteName),
                    ReportField("Location ", report.location),
                    ReportField("DateOfVisit ", report.dateOfVisit),
                    ReportField("PumpCapacity ", "${report.pumpCapacity} m³/h"),
                    ReportField("PumpEfficiency ", "${report.pumpEfficiency} %"),
                    ReportField("LiquidTemperature ", "${report.liquidTemperature} °C"),
                    ReportField("ElectricalPowerConsumption ", "${report.electricalPowerConsumption} kW"),
                    ReportField("InstallationDate ", report.installationDate),
                    ReportField("LastServiceDate ", report.lastServiceDate),
                    ReportField("SubmitReportDate ", report.submitReportDate),
                    SizeBox(20),
                    CommentBox(report.reportId)
                  ],
                )),
          )),
    );
  }
}

//ReportField
class ReportField extends StatelessWidget {
  final String value;
  final String field;
  const ReportField(this.field, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Row(
        spacing: 10,
        children: [
          CustomText("$field : ", 16, FontWeight.bold, Colors.black54),
          CustomText("$value. ", 16, FontWeight.normal, Colors.black54),
        ],
      ),
    );
  }
}


