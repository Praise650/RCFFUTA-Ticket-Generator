import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/personal_data.dart';
import '../../../../core/models/zone_model.dart';
import '../../../../core/repos/rcf_zones_repo.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/service/navigator_service.dart';
import '../../../../core/states/ticket_state.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_response.dart';
import '../../../../utils/id_generator.dart';
import '../../../../app/locator.dart';

class GenerateQrViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _fService = locator<FireStoreService>();
  final _navigationService = locator<NavigatorService>();
  final _zonesRepo = RcfZonesRepo();
  RcfZonesRepo get zonesRepo => _zonesRepo;
  ITicketState state = ITicketState();
  // late User? user;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController church = TextEditingController();
  TextEditingController school = TextEditingController();
  String? gender = 'Male';
  RcfZones? selectedZone;
  String? selectedInstitution;
  String? selectedUnit;
  String? selectedPortfolio;

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void init() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _zonesRepo.fetchData();
      notifyListeners();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  void createAndSaveUser() async {
    // if (saveAndValidate() && isNotNull()) {
    if (saveAndValidate()) {
      print("state of formKey: ${saveAndValidate()} and ${isNotNull()}");
      _isLoading = true;
      notifyListeners();
      try {
        // user = await _authService.register(
        //     email: email.text, password: phoneNumber.text);

        final personalDataForm = PersonalDataForm(
          id: _fService.generateId,
          fullname: ("${lastname.text} ${firstname.text}").toString(),
          lastname: lastname.text,
          firstname: firstname.text,
          // email: email.text,
          phoneNumber: phoneNumber.text,
          gender: gender,
          age: age.text,
          church: church.text,
          school: school.text,
          // zone: selectedZone!.zone,
          // fellowshipName: selectedInstitution,
          // unit: selectedUnit,
          // portfolio: selectedPortfolio ?? 'Nil',
          uuid:
              IDGenerator.createId(firstname.text, lastname.text).toUpperCase(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          attending: false,
          isAdmin: false,
        );
        notifyListeners();
        print("PersonalDataForm: ${personalDataForm.toJson()}");
        if (personalDataForm.isDefinedAndNotNull) {
          _fService
              .uploadMemberInformation(personalDataForm.toJson(), personalDataForm.id!)
              .then(
                (value) => _navigationService.replace(
                  AppRoutes.thankYou
                ),
              );
        }
        notifyListeners();
      } catch (e) {
        notifyListeners();
        _isLoading = false;
        print(e);
      }
    } else {
      print("Error can't save data");
      AppResponse.error("Error cant create user, Please fill all field");
      _isLoading = false;
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

  bool isNotNull() {
    if (selectedZone != null &&
        selectedInstitution!.isNotEmpty &&
        selectedUnit!.isNotEmpty &&
        selectedPortfolio!.isNotEmpty) {
      return true;
    }
    return false;
  }

  updateInstitution() {
    _zonesRepo.fetchInstitutions(selectedZone!);
    notifyListeners();
  }
}
