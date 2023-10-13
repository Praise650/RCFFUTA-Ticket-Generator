import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/firestore_service.dart';
import '../models/personal_data.dart';

class UserRepo implements FireStoreService {
  final _fsInstance = FirebaseFirestore.instance;
  // String? _userId;
  final String membersCollectionPath = "Attendees";
  final String adminCollectionPath = "Admins";
  late CollectionReference<Map<String, dynamic>> _membersCollection;
  late CollectionReference<Map<String, dynamic>> _adminCollection;

  CollectionReference<Map<String, dynamic>> get adminCollection =>
      _adminCollection;
  CollectionReference<Map<String, dynamic>> get membersCollection =>
      _membersCollection;

  UserRepo() {
    initialize();
  }

  void initialize() {
    // _userId = userId;
    _membersCollection = _fsInstance.collection(membersCollectionPath);
    _adminCollection = _fsInstance.collection(adminCollectionPath);
  }

  @override
  Future<List<PersonalDataForm>> getMembersCollection() async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _fsInstance.collection(membersCollectionPath).limit(20).get();
    Map<String, List<String>> dataJson = {};

    // await extractAndDownloadData(response, dataJson);
    print("Number of people registered: ${response.docs.length}");
    List<PersonalDataForm> membersData = response.docs.map((e) {
      return PersonalDataForm.fromJson(e.data());
    }).toList();
    return membersData; // _widowsData;
  }

  @override
  Future<PersonalDataForm> getCurrentUser(String userId) async {
    final currentUser = await _membersCollection.doc(userId).get();
    if (currentUser.exists) {
      final decodedData = currentUser.data();
      return PersonalDataForm.fromJson(decodedData!);
      // showDialog(
      //   context: context,
      //   builder: (context) => const FlutterSuccessfulDialog(
      //     title: "Successful",
      //     subtitle: "Your details have been save successfully",
      //     routeDes: SiteLayout(),
      //   ),
      // );
    } else {
      throw Exception('Could not fetch user');
    }
  }

  @override
  Future<void> uploadMemberInformation(
      Map<String, dynamic> jsonData, uid) async {
    await _fsInstance.collection(membersCollectionPath).doc(uid).set(jsonData);
  }

  @override
  Future<void> saveDataAsJson(List<Map<String, String>> list) async {}

  @override
  Future<bool> checkUserIsCreated(String userId) async {
    var createdMember = await _membersCollection.doc(userId).get();
    return createdMember.data()!.isEmpty ? false : true;
  }

  @override
  Future<void> extractAndDownloadData(
      QuerySnapshot<Map<String, dynamic>> response,
      Map<String, List<String>> dataJson) async {
    for (Map<String, dynamic> doc in (response.docs.map((e) => e.data()))) {
      for (MapEntry entry in doc.entries) {
        List<String> prevList = dataJson[entry.key] ?? [];
        prevList.add(entry.value?.toString() ?? "");
        dataJson[entry.key] = prevList;
      }
    }

    final data = response.docs.map((e) => (e.data())
        .map((key, value) => MapEntry(key, value?.toString() ?? "")));
    await saveDataAsJson(data.toList());

    // List<List<String>> data = [];
    // List<String> keysRow = dataJson.keys.toList();
    // data.add(keysRow);
    // for (int i = 0; i < dataJson.length; i++) {
    //   List<String> row = [];
    //   for (int j = 0; j < keysRow.length; j++) {
    //     row.add(dataJson[keysRow[j]]![i]);
    //   }
    //   data.add(row);
    // }
    //
    // await saveDataAsCsv(data);

    print("Number of Data converted: ${data.length}");
  }
}
