import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../core/models/personal_data.dart';
import '../core/service/firestore_service.dart';
import '../firebase_options.dart';
import 'locator.dart';

class App {
  // static const bool useLocalData = true;
  static final _store = locator<FireStoreService>();

  static Future<void> initialize() async {
    print("Initializing App....");
    print("Checking and binding firebase....");
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Initializing locator...");
    setupLocator();
    print("Getting list of attendees from firebase....");
    await getListOfUsers();
    print("Initialization Complete");
  }

  static Future<List<PersonalDataForm>> getListOfUsers() async {
    List<PersonalDataForm> childrenList = await _store.getMembersCollection();
    print("First attendees in User Repo: ${childrenList[0]}");
    return childrenList;
  }
}
