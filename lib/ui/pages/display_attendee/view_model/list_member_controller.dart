import 'package:flutter/cupertino.dart';
import 'package:rcf_attendance_generator/core/service/navigator_service.dart';
import 'package:rcf_attendance_generator/utils/app_response.dart';

import '../../../../app/locator.dart';
import '../../../../core/models/personal_data.dart';
import '../../../../core/service/firestore_service.dart';

class DispController extends ChangeNotifier{
  final _fService = locator<FireStoreService>();
  TextEditingController searchController = TextEditingController();
  final _navigationService = locator<NavigatorService>();

  bool _loading = false;
  bool get loading => _loading;

  List<PersonalDataForm> users =[];

  // helps in filtering the already gotten list
  List<PersonalDataForm> filteredCards = [];

  getUsers(bool? cat) async{
    users.clear();
    _loading = true;
    notifyListeners();
    try {
    List<PersonalDataForm>? rawUsersList;
    if(cat != null) {
      rawUsersList =  await _fService.getMembersCollection();
      print("Number of registered people: ${rawUsersList.length}");
      notifyListeners();
      users = rawUsersList.where((element) => element.attending == cat).toList();
      _loading = false;
      notifyListeners();
    } else {
      users =  await _fService.getMembersCollection();
      print("Number of registered people: ${users.length}");
      _loading = false;
      notifyListeners();
    }
    } catch (e) {
      print(e);
      _loading = false;
      notifyListeners();
      AppResponse.error("Failed to get users");
    }
  }

  searchForCard() {
    filteredCards.clear();
    if (searchController.text.isEmpty) {
      notifyListeners();
      return;
    }

    for (var element in users) {
      if (element.uuid!.toLowerCase().contains(searchController.text)) {
        filteredCards.add(element);
      }
      notifyListeners();
    }
  }

  // Future<void> onSearch(String search) async {
  //   List<PersonalDataForm> newList = users
  //       .where(
  //         (element) => element.uuid!.contains(
  //       RegExp(search, caseSensitive: false),
  //     ),
  //   )
  //       .toList();
  //   // for (var element in newList) {
  //   //   // print(newList);
  //   //   // print('These are items in new list ${element.category}');
  //   // }
  //   //emit here
  //   users = newList;
  //   notifyListeners();
  // }
  updateStatus(String id){
    try {
      _fService.updateMemberInformation({'attending': true},id).then((value) {
        _navigationService.back();
        AppResponse.success("Successful");
      });
    } catch (e){
      print(e);
      AppResponse.error("Failed to verify");
    }
  }
}