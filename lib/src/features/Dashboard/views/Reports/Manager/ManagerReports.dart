import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';
import '../../../../../constants/constants.dart';
import '../SingleReport.dart';

class ManagerReports extends StatefulWidget {
  const ManagerReports({super.key});
  @override
  State<StatefulWidget> createState() => ManagerReportState();
}

//Manager Reports State
class ManagerReportState extends State<ManagerReports> {
  @override
  void initState() {
    getReports();
    super.initState();
  }

  final List<ReportDto> arrReports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomText( "Reports ", 18,
              FontWeight.bold, AppColors.mainColor),
        ),
        backgroundColor: AppColors.lightBlue,
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Icon(
            Icons.menu_book_outlined,
            color: AppColors.mainColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              // CustomSearch<ReportDto>(
              //   "Search Report",
              //   arrReports,
              //  (report, controller) => ListTile(
              //     title: Text(report.customerName),
              //     onTap: () => controller.closeView(report.customerName),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: 2,
              //   ),
              //   child: Row(
              //     children: [
              //       Chips(),
              //     ],
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: arrReports.length,
                  itemBuilder: (context, index) {
                    return SingleReport(arrReports[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getReports() async {
    try {
      var data = await FireBaseApi.getByField(FireBaseConstant.reportCollection,
          "managerId", "DWsbbEZrRAvrKkp0IKzy");
      final List<ReportDto> tempReports = [];

      for (var doc in data) {
        print("Report Data is ${doc.id}");
        DateTime dateTime = doc.data()['submitReportDate'].toDate();
        String formattedDate = DateFormat('MMM d, yyyy HH:mm a').format(dateTime);

        tempReports.add(ReportDto(
          reportId: doc.id,
          customerName: doc.data()['customerName'],
          siteName: doc.data()['siteName'],
          location: doc.data()['location'],
          dateOfVisit: doc.data()['dateOfVisit'],
          pumpCapacity: doc.data()['pumpCapacity'],
          pumpEfficiency: doc.data()['pumpEfficiency'],
          liquidTemperature: doc.data()['liquidTemperature'],
          electricalPowerConsumption: doc.data()['electricalPower'],
          installationDate: doc.data()['installationDate'],
          lastServiceDate: doc.data()['lastServiceDate'],
          submitReportDate: formattedDate,
        ));
      }
      setState(() {
        arrReports.addAll(tempReports);
      });
    } catch (err) {
      print("error when report fetch $err");
    }
  }
}
