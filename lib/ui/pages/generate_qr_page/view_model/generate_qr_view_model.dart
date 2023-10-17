import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcf_attendance_generator/core/service/navigator_service.dart';

import '../../../../core/models/personal_data.dart';
import '../../../../core/models/zone_model.dart';
import '../../../../core/repos/rcf_zones_repo.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/states/ticket_state.dart';
import '../../../../utils/id_generator.dart';
import '../../../../app/locator.dart';

class GenerateQrViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _fService = locator<FireStoreService>();
  final _navigatorService = locator<NavigatorService>();
  final RcfZonesRepo _rcfZonesRepo = RcfZonesRepo();
  ITicketState state = ITicketState();
  late User? user;
  List<RcfZones> rcfZonesList = [];
  RcfZones? selectedRcfZone;
  List<Institution> institutionList = [];
  String? selectedInstitution;
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
  bool get isLoading => _isLoading;

  void init() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _rcfZonesRepo.getZones().then((value) {
        rcfZonesList = value.data!;
        for (var rcfZone in rcfZonesList) {
          print("In the zone ${rcfZone.zone}");
        }
        notifyListeners();
      });
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  void createAndSaveUser(BuildContext context) async {
    if (saveAndValidate()) {
      print("state of ${saveAndValidate()}");
      _isLoading = true;
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
          // zone: zone.text,
          unit: unit.text,
          workerOrExec: workerOrExec.text,
          portfolio: portfolio.text,
          uuid:
              IDGenerator.createId(firstname.text, lastname.text).toLowerCase(),
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
                (value) =>
                    _navigatorService.navigateToDownloadQrPage(user!.uid),
              );
        }
        // _userRepo.createUser(toJson,context);
        notifyListeners();
      } catch (e) {
        notifyListeners();
        _isLoading = false;
        print(e);
      }
    } else {
      print("Error can't save data");
      // AppResponse.showErrorMessage("Error cant create user");
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

  updateInstitution() {
    state = LoadingTicketState();
    notifyListeners();
    institutionList = selectedRcfZone!.institutions!;
    for(var newVal in institutionList) {
      print("Institution List: ${newVal.fellowshipName}");
    }
    institutionList.isNotEmpty
        ? state = SuccessTicketState()
        : state = FailureTicketState();
    notifyListeners();
  }
}
