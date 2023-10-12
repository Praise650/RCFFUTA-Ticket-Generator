import 'package:flutter/material.dart';

import '../../../../core/repos/user_repo.dart';
import '../../download_qr/download_qr.dart';



class GenerateQrViewModel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  String? gender = 'Male';
  String? isExecutive = "No";
  String? isAWorker = "Yes";
  TextEditingController email = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController homeAddress = TextEditingController();
  TextEditingController schoolAddress = TextEditingController();
  TextEditingController yearOfGraduation = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController sessionOfAdmission = TextEditingController();
  TextEditingController executivePosition = TextEditingController();

  final formKey = GlobalKey<FormState>();

  createAndSaveUser(
    BuildContext context,
    VoidCallback calltrue,
    VoidCallback callfalse,
  ) {
    calltrue.call();
    notifyListeners();
    try {
      if (saveAndValidate() == true) {
        print("state of ${saveAndValidate()}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DownloadQR()));
        // print(toJson);
        //   PersonalDataForm _personalDataForm = PersonalDataForm(
        //     lastname: lastname.text,
        //     firstname: firstname.text,
        //     gender: gender,
        //     email: email.text,
        //     department: department.text,
        //     homeAddress: homeAddress.text,
        //     yearOfGraduation: int.parse(yearOfGraduation.text),
        //     sessionOfAdmission: int.parse(sessionOfAdmission.text),
        //     fullname: (lastname.text +""+ firstname.text).toString(),
        //     phoneNumber: phoneNumber,
        //   );
        Map<String, dynamic> toJson = {
          'fullName': (lastname.text +""+ firstname.text).toString(),
          'firstname': firstname.text,
          'lastname': lastname.text,
          'email': email.text,
          'gender': gender?.toLowerCase(),
          'department': department.text,
          'home_address': homeAddress.text,
          'schoolAddress': schoolAddress.text,
          'year_of_grad': yearOfGraduation.text,
          "isExecutive": isExecutive,
          "isAWorker": isAWorker,
        "unitPosition": unit,
        'sessionOfAdmission':sessionOfAdmission,
        'executivePosition':executivePosition,
        };
        notifyListeners();
        print(toJson);
        // _userRepo.firestoreUser(phoneNumber, toJson, context);
        // _userRepo.createUser(toJson,context);
        callfalse.call();
        notifyListeners();
      } else {
        print("Error can't save data");
        // AppResponse.showErrorMessage("Error cant create user");
        callfalse.call();
        notifyListeners();
      }
    } catch (e) {
      callfalse.call();
      notifyListeners();
      print(e);
    }
    callfalse.call();
    notifyListeners();
  }

  bool saveAndValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
