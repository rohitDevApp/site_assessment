import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';
import 'package:site_assessment/src/utils/user.dart';

import '../../../../../common_widgets/DialogBox.dart';
import '../../../../../common_widgets/SnackBar.dart';


class SingleOfficer extends StatefulWidget {
  final OfficerLabel data;
  final String action;
  final String docId;
  final VoidCallback fetchData;

  const SingleOfficer(this.data, this.action, this.docId, this.fetchData,
      {super.key});

  @override
  State<StatefulWidget> createState() => SingleStateOfficer();
}

//State
class SingleStateOfficer extends State<SingleOfficer> {
  @override
  Widget build(BuildContext context) {
    bool isActive = widget.data.status == "Active";
    bool isSelected = widget.data.isSelected;

    String avtarName = widget.data.fullName.split(" ").first[0] +
        widget.data.fullName.split(" ").last[0];

    return Visibility(
        visible: widget.data.officerId.isEmpty ? false : true,
        child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            backgroundColor: AppColors.mainColor,
                            child: CustomText(
                                avtarName, 14, FontWeight.bold, Colors.white),
                          ),
                        ),
                        if (isActive)
                          Positioned(
                              right: 2.2,
                              top: 2.2,
                              child: Container(
                                padding: EdgeInsets.all(4.4),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(90)),
                              ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(widget.data.fullName, 16, FontWeight.bold,
                            Colors.black54),
                        CustomText(widget.data.email, 13, FontWeight.bold,
                            Colors.black54),
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: isSelected ? null: () async {

                      var id = await SharedPreferencesHelper.getPrefValue(
                          KEYS.userId);
                      showDialogBox(context, widget.data.email,
                          "Are you sure you want to ${widget.action} ? ",
                          (confirm) async {
                        print(confirm);
                        if (confirm) {
                          handlerOfficerAction(
                              widget.action, widget.data, id, widget.docId);
                          widget.fetchData();
                        }
                      });
                    },
                    icon: Icon(
                      widget.action !="add" ? Icons.remove : Icons.add,
                      size: 35,
                      color: isSelected ? Colors.grey: Colors.black54,
                    ))
              ],
            )));
  }

  //handlerOfficerAction
  void handlerOfficerAction(
      String action, OfficerLabel data, String managerId, String docId) async {
    final officerData = <String, dynamic>{
      "managerId": managerId,
      "officerId": data.officerId,
      "fullName": data.fullName,
      "email": data.email,
    };
    if (action == 'add') {
      await FireBaseApi.insert(FireBaseConstant.teamsCollection, officerData);
      if (mounted) {
        ActionSnackBar.show(context, 'Added');
      }
    } else {
      var res = await FireBaseApi.deleteDocument(
          FireBaseConstant.teamsCollection, docId);
      if (mounted) {
        ActionSnackBar.show(context, "Removed");
      }
      print("Remove $res");
    }
  }
  // });
  // }
}
