import 'package:flutter/cupertino.dart';

import '../../../../api/firebaseApi.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/firebase.dart';
import '../../../../utils/SharedPreferencesHelper.dart';

class ReportProvider with ChangeNotifier {
  bool isTeamMember = false;
  bool isLoading = true;

  //checkOfficer In team or not
  Future<void> checkOfficerTeam() async {
    try {
      var userId =
          await SharedPreferencesHelper.getPrefValue(KEYS.userId) ?? '';
      var docs = await FireBaseApi.getByField(
          FireBaseConstant.teamsCollection, "officerId", userId);

      if (docs[0]['managerId'] != '') {
        await SharedPreferencesHelper.setPrefValue(
            KEYS.managerId, docs[0]['managerId']);
        isTeamMember = true;
      } else {
        isTeamMember = false;
        await SharedPreferencesHelper.setPrefValue(KEYS.managerId, "");
      }
    } catch (err) {
      print("Error in checkOfficerTeam: $err");
      isTeamMember = false;
      await SharedPreferencesHelper.setPrefValue(KEYS.managerId, "");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
