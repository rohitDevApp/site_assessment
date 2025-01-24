import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Teams/SingleOfficer.dart';

class MyOfficer extends StatefulWidget {
  const MyOfficer({super.key});

  @override
  State<StatefulWidget> createState() => MyOfficerState();
}

//State AddOfficer
class MyOfficerState extends State<MyOfficer> {
  bool isFormSubmitted = false;
  bool isChecked = false;
  final TextEditingController dropDownController = TextEditingController();
  OfficerLabel? selectedOfficer;
  List<OfficerLabel> officerData = [
    OfficerLabel("Ronit Kumar", "", "InActive", "", "", isSelected: true)
  ];

  @override
  void initState() {
    super.initState();
    selectedOfficer = officerData.first;
    fetchMyOfficer();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: officerData.length,
        itemBuilder: (BuildContext context, int index) {
          var data = officerData[index];
          return SingleOfficer(data, "remove", data.docId, refreshData);
        });
  }

  //Re fetchData
  void refreshData() {
    fetchMyOfficer();
  }

  //fetchMyOfficer
  void fetchMyOfficer() async {
    var data = await FireBaseApi.get(FireBaseConstant.teamsCollection);
    List<OfficerLabel> tempOfficerData = [];
    for (var doc in data) {
      tempOfficerData.add(OfficerLabel(doc.data()['fullName'],
          doc.data()["officerId"], "Active", doc.data()["email"], doc.id,
          ));
    }
    setState(() {
      officerData = tempOfficerData;
    });
  }
}
