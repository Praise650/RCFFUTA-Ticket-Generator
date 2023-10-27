// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rcf_attendance_generator/utils/app_response.dart';
import 'dart:ui';

import '../../../../core/service/download_qr_service.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/models/personal_data.dart';
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

  Future<void> uploadTicket(Uint8List? bytes) async {
    // getPdf(bytes!);
    try {
      print("Uploading ticket");
      print("User Id: ${user!.uuid} and ${bytes.runtimeType}");
      await _downloadService.downloadTicket(
        id: user!.uuid!,
        bytes: bytes!,
      );
      print("Upload successful");

    } catch (e) {
      print(e);
    }

    // final islandRef = FirebaseStorage.instance.ref().child("Folder/${user!.uuid}");
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final filePath = "${appDocDir.path}/ticket${islandRef.name}";
    // final file = io.File(filePath);

    // final downloadTask = islandRef.writeToFile(file);
    // downloadTask.snapshotEvents.listen((taskSnapshot) {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //     // TODO: Handle this case.
    //       break;
    //     case TaskState.paused:
    //     // TODO: Handle this case.
    //       break;
    //     case TaskState.success:
    //     // TODO: Handle this case.
    //       break;
    //     case TaskState.canceled:
    //     // TODO: Handle this case.
    //       break;
    //     case TaskState.error:
    //     // TODO: Handle this case.
    //       break;
    //   }
    // });
  }

  Future<void> captureAndSavePng() async {
    state = LoadingTicketState();
    notifyListeners();
    print("Starting download ...");
    try{
      RenderRepaintBoundary boundary = _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      print("Image captured");
      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,Rect.fromLTWH(0,0,image.width.toDouble(),image.height.toDouble()));
      canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      uploadTicket(pngBytes);
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
