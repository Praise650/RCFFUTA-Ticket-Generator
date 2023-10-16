import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/service/auth_service.dart';
import '../../../../app/locator.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  // late User? user;
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();

  final login = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // set isLoading(bool value) {
  //   _isLoading = value;
  // }

  void createAndSaveUser() async {
    if (saveAndValidate()) {
      print("state of ${saveAndValidate()}");
      _isLoading = true;
      notifyListeners();
      try {
        await _authService.login(
            email: email.text, password: lastname.text);
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        notifyListeners();
        _isLoading = false;
        print(e);
      }
    } else {
      print("Error the field cannot be empty");
      // AppResponse.showErrorMessage("Error cant create user");
      _isLoading = false;
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
