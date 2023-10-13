import 'package:flutter/cupertino.dart';

import '../../../../app/locator.dart';
import '../../../../core/models/personal_data.dart';
import '../../../../core/service/firestore_service.dart';

class DispController extends ChangeNotifier{
  final _fService = locator<FireStoreService>();
  TextEditingController searchController = TextEditingController();

  List<PersonalDataForm> users =[];

  // helps in filtering the already gotten list

  List<PersonalDataForm> filteredCards = [];

  getUsers()async{
    users =  await _fService.getMembersCollection();
    notifyListeners();
  }

  searchForCard(String card) {
    filteredCards.clear();
    if (card.isEmpty) {
      notifyListeners();
      return;
    }

    for (var element in users) {
      if (element.id!.toLowerCase().contains(card)) {
        filteredCards.add(element);
      }
      notifyListeners();
    }
  }

  Future<void> onSearch(String search) async {
    List<PersonalDataForm> newList = users
        .where(
          (element) => element.id!.contains(
        RegExp(search, caseSensitive: false),
      ),
    )
        .toList();
    // for (var element in newList) {
    //   // print(newList);
    //   // print('These are items in new list ${element.category}');
    // }
    //emit here
    users = newList;
    notifyListeners();
  }
}