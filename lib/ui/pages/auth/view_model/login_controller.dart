import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../display_attendee/list_members.dart';
import '../../../../app/locator.dart';
import '../../generate_qr_page/generate_qr_page.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _fService = locator<FireStoreService>();
  late User? user;
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();

  final login = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => false;

  set isLoading(bool value) {
    _isLoading = value;
  }

  void createAndSaveUser(BuildContext context) async {
    if (saveAndValidate()) {
      print("state of ${saveAndValidate()}");
      isLoading = true;
      notifyListeners();
      if(lastname.text == 'Sotomi' && email.text=="olamijisotomi@gmail.com"){
      try {
        user = await _authService.login(
            email: email.text, password: lastname.text);
        // PersonalDataForm _personalDataForm = PersonalDataForm(
        //   id: user!.uid,
        //   lastname: lastname.text,
        //   email: email.text,
        //   createdAt: DateTime.now(),
        //   updatedAt: DateTime.now(),
        //   attending: true,
        // );
        notifyListeners();
        // print("PersonalDataForm: ${_personalDataForm.toJson()}");
        if (user != null) {
          // _fService
              // .uploadMemberInformation(_personalDataForm.toJson(), user?.uid)
              // .then(
              //   (value) =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListUsersPage(),
              ),
          );
        }
        // _userRepo.createUser(toJson,context);
        notifyListeners();
      } catch (e) {
        notifyListeners();
        isLoading = false;
        print(e);
      }
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GenerateQRPage(),
          ),
        );
      }
    } else {
      print("Error can't save data");
      // AppResponse.showErrorMessage("Error cant create user");
      isLoading = false;
      notifyListeners();
      return;
    }
  }

  bool saveAndValidate() {
    if (login.currentState!.validate()) {
      login.currentState!.save();
      return true;
    }
    return false;
  }
}
