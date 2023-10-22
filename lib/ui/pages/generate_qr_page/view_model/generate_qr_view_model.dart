import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/personal_data.dart';
import '../../../../core/models/zone_model.dart';
import '../../../../core/repos/rcf_zones_repo.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/states/ticket_state.dart';
import '../../../../utils/id_generator.dart';
import '../../../../app/locator.dart';
import '../../download_qr/download_qr.dart';

class GenerateQrViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _fService = locator<FireStoreService>();
  final RcfZonesRepo _zonesRepo = RcfZonesRepo();
  RcfZonesRepo get zonesRepo => _zonesRepo;
  ITicketState state = ITicketState();
  late User? user;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
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

  void createAndSaveUser(BuildContext context) async {
    if (saveAndValidate()) {
      print("state of ${saveAndValidate()}");
      _isLoading = true;
      notifyListeners();
      try {
        user = await _authService.register(
            email: email.text, password: phoneNumber.text);
        PersonalDataForm personalDataForm = PersonalDataForm(
          id: user!.uid,
          fullname: ("${lastname.text} ${firstname.text}").toString(),
          lastname: lastname.text,
          firstname: firstname.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          gender: gender,
          zone: selectedZone!.zone,
          fellowshipName: selectedInstitution,
          unit: selectedUnit,
          portfolio: selectedPortfolio,
          uuid:
              IDGenerator.createId(firstname.text, lastname.text).toUpperCase(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          attending: false,
        );
        notifyListeners();
        print("PersonalDataForm: ${personalDataForm.toJson()}");
        if (user != null) {
          _fService
              .uploadMemberInformation(personalDataForm.toJson(), user?.uid)
              .then(
                (value) =>Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadQRPage(
                      userId: user!.uid.toString(),
                    ),
                  ),
                ),
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
    _zonesRepo.fetchInstitutions(selectedZone!);
    notifyListeners();
  }
}
