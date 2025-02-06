import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../api/firebaseApi.dart';
import '../../../../../common_widgets/SnackBar.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../constants/firebase.dart';

class SingleOfficerController extends GetxController {
  var data = <OfficerLabel>[].obs;

  //handlerOfficerAction
  void handlerOfficerAction(String action, OfficerLabel data, String managerId,
      String docId, BuildContext context) async {
    final officerData = <String, dynamic>{
      "managerId": managerId,
      "officerId": data.officerId,
      "fullName": data.fullName,
      "email": data.email,
    };
    if (action == 'add') {
      await FireBaseApi.insert(FireBaseConstant.teamsCollection, officerData);
      ActionSnackBar.show(context, 'Added');
    } else {
      var res = await FireBaseApi.deleteDocument(
          FireBaseConstant.teamsCollection, docId);
      ActionSnackBar.show(context, "Removed");
    }
  }
}
