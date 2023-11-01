// ignore_for_file: avoid_print
import 'dart:js_interop';

import 'package:flutter/material.dart';

import '../../../../core/service/download_ticket_service.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/models/personal_data.dart';
import '../../../../core/states/ticket_state.dart';
import '../../../../app/locator.dart';

class DownloadQrController extends ChangeNotifier {
  final _fService = locator<FireStoreService>();
  final _downloadService = locator<DownloadTicketService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PersonalDataForm? user;
  ITicketState state = ITicketState();
  final GlobalKey _qrkey = GlobalKey();
  GlobalKey get qrKey => _qrkey;

  Future<void> getProfile(userId) async {
    state = LoadingTicketState();
    notifyListeners();
    user = await _fService.getCurrentUser(userId);
    user.isDefinedAndNotNull
        ? state = SuccessTicketState()
        : state = FailureTicketState();
    notifyListeners();
  }

  Future<void> captureAndSavePng() async {
    _isLoading = true;
    notifyListeners();
    try {
      await  _downloadService.captureAndSavePng(qrkey: _qrkey).then((value) async=>
           await _downloadService.convertToPdf(user!.uuid!).then((value) async=>
              user!.imageUrl == null
                  ? await _downloadService.uploadFileToStorage(user!.uuid!,user!.id!)
                  : await _downloadService.downloadTicketToDevice(
                      id: user!.uuid!)))
          .then((value) {
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }
}
