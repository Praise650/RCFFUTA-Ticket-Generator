// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'dart:js_interop';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rcf_attendance_generator/utils/app_response.dart';

import '../../../../core/service/download_ticket_service.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/models/personal_data.dart';
import '../../../../core/service/navigator_service.dart';
import '../../../../core/states/ticket_state.dart';
import '../../../../app/locator.dart';

class DownloadQrController extends ChangeNotifier {
  final _fService = locator<FireStoreService>();
  final _downloadService = locator<DownloadTicketService>();

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
    state = LoadingTicketState();
    notifyListeners();
    print("Starting download ...");
    try{

      // uploadTicket(pngBytes);
      _showQRandPrint(pngBytes);
      print("Image downloaded");
      AppResponse.success("Download Successful");
      state = SuccessTicketState();
      notifyListeners();
    }catch(e){
      state = FailureTicketState();
      AppResponse.error("Failed to download, Please try again");
      notifyListeners();
    }
  }
}
