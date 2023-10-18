import 'package:flutter/material.dart';

import '../../../../core/service/auth_service.dart';
import '../../../../app/locator.dart';
import '../../download_qr/download_qr.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();

  final login = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void createAndSaveUser(context) async {
    if (saveAndValidate()) {
      _isLoading = true;
      notifyListeners();
      try {
        final userDataCreated = await _authService.login(
            email: email.text, password: lastname.text);
        if (userDataCreated != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DownloadQRPage(
                userId: userDataCreated.id!,
              ),
            ),
          );
        }
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
  void loginAsAdmin(context) async {
    if (saveAndValidate()) {
      _isLoading = true;
      notifyListeners();
      try {
        await _authService.loginAsAdmin(
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
