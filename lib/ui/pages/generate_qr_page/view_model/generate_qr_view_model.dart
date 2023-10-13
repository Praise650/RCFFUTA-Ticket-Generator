import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/personal_data.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../utils/id_generator.dart';
import '../../download_qr/download_qr.dart';
import '../../../../app/locator.dart';

class GenerateQrViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _fService = locator<FireStoreService>();
  late User? user;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String? gender = 'Male';
  TextEditingController zone = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController workerOrExec = TextEditingController();
  TextEditingController portfolio = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
      try {
        user = await _authService.register(
            email: email.text, password: lastname.text);
        PersonalDataForm _personalDataForm = PersonalDataForm(
          id: user!.uid,
          fullname: ("${lastname.text} ${firstname.text}").toString(),
          lastname: lastname.text,
          firstname: firstname.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          gender: gender,
          zone: zone.text,
          unit: unit.text,
          workerOrExec: workerOrExec.text,
          portfolio: portfolio.text,
          uuid: IDGenerator.createId(firstname.text, lastname.text).toLowerCase(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          attending: false,
        );
        notifyListeners();
        print("PersonalDataForm: ${_personalDataForm.toJson()}");
        if (user != null) {
          _fService
              .uploadMemberInformation(_personalDataForm.toJson(), user?.uid)
              .then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadQR(
                      userId: user!.uid,
                    ),
                  ),
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
    } else {
      print("Error can't save data");
      // AppResponse.showErrorMessage("Error cant create user");
      isLoading = false;
      notifyListeners();
      return;
    }
  }

  bool saveAndValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
