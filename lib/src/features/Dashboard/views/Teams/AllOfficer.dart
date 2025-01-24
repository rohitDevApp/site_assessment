import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/firebase.dart';

import 'SingleOfficer.dart';

class AllOfficer extends StatefulWidget {
  const AllOfficer({super.key});

  @override
  State<StatefulWidget> createState() => OfficerState();
}

//State AddOfficer
class OfficerState extends State<AllOfficer> {
  bool isFormSubmitted = false;
  bool isChecked = false;
  final TextEditingController dropDownController = TextEditingController();
  OfficerLabel? selectedOfficer;
  List<OfficerLabel> officerData = [
    OfficerLabel("Ronit Kumar", "", "InActive", "", " ", isSelected: true),
  ];

  @override
  void initState() {
    super.initState();
    selectedOfficer = officerData.first;
    fetchAllOfficer();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: officerData.length,
        itemBuilder: (BuildContext context, int index) {
          var data = officerData[index];
          return SingleOfficer(data, "add", data.docId, refreshData);
        });
  }

  //Re fetchData
  void refreshData() {
    fetchAllOfficer();
  }

  //Fetch All Officer
  void fetchAllOfficer() async {
    var data = await FireBaseApi.getByField(
        FireBaseConstant.usersCollection, "Role", "Officer");
    var teamData = await FireBaseApi.get(FireBaseConstant.teamsCollection);
    List<OfficerLabel> tempOfficerData = [];
    List<String> tempTeamIds = [];

    //Teams Ids
    for (var team in teamData) {
      tempTeamIds.add(team.data()['officerId']);
    }

    //All Officer
    for (var doc in data) {
      var isSelected = tempTeamIds.contains(doc.id);
      tempOfficerData.add(OfficerLabel(
          doc.data()['fullName'], doc.id, "Active", doc.data()['email'], doc.id,
          isSelected: isSelected));
    }

    //update List
    setState(() {
      officerData = tempOfficerData;
    });
  }
}
