import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';
import '../../../../../common_widgets/Chips.dart';
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
        title: CustomText("Reports", 18, FontWeight.bold, Colors.black54),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      hintText: "Search Report",
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return arrReports.map((index) {
                      return ListTile(
                        title: Text(index.customerName),
                        onTap: () {
                          setState(() {
                            controller.closeView(index.customerName);
                          });
                        },
                      );
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2,
                ),
                child: Row(
                  children: [
                    Chips(),
                  ],
                ),
              ),
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
