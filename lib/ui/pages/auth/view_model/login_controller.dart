import 'package:flutter/material.dart';

import '../../../../core/service/auth_service.dart';
import '../../../../app/locator.dart';
import '../../../../utils/app_response.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();

  final login = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isAdminLoading = false;
  bool get isAdminLoading => _isAdminLoading;

  void createAndSaveUser() async {
    if (saveAndValidate()) {
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
      AppResponse.error("Field cannot be empty");
      _isLoading = false;
      notifyListeners();
      return;
    }
  }
  void loginAsAdmin() async {
    if (saveAndValidate()) {
      _isAdminLoading = true;
      notifyListeners();
      try {
        await _authService.loginAsAdmin(
            email: email.text, password: lastname.text);
        _isAdminLoading = false;
        notifyListeners();
      } catch (e) {
        notifyListeners();
        _isAdminLoading = false;
        print(e);
      }
    } else {
      print("Error the field cannot be empty");
      AppResponse.error("Error the field cannot be empty");
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
