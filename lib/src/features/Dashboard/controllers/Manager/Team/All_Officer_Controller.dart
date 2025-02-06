import 'package:get/get.dart';

import '../../../../../api/firebaseApi.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../constants/firebase.dart';

class AllOfficerController extends GetxController {
  var isLoading = true.obs;
  var officerData = <OfficerLabel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOfficer();
  }

  //Fetch All Officer
  Future<void> fetchAllOfficer() async {
    try {
      var data = await FireBaseApi.getByField(
          FireBaseConstant.usersCollection, "Role", "Officer");
      var teamData = await FireBaseApi.get(FireBaseConstant.teamsCollection);
      List<OfficerLabel> tempOfficerData = [];
      List<String> tempTeamIds = [];

      //Teams Ids
      for (var team in teamData) {
        tempTeamIds.add(team.data()['officerId']);
      }
      print(tempTeamIds);
      //All Officer
      for (var doc in data) {
        var isSelected = tempTeamIds.contains(doc.id);
        tempOfficerData.add(OfficerLabel(doc.data()['fullName'], doc.id,
            "Active", doc.data()['email'], doc.id,
            isSelected: isSelected));
      }

      //update List
      officerData.value = tempOfficerData;
    } catch (err) {
      print("Error fetching officers: $err");
    } finally {
      isLoading.value = false;
    }
  }
}
