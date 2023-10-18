import 'package:rcf_attendance_generator/routes/app_routes.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../app/locator.dart';
import '../../../../core/models/personal_data.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../../core/service/navigator_service.dart';
import '../../../../core/states/ticket_state.dart';

class DownloadQrController extends ChangeNotifier {
  final _fService = locator<FireStoreService>();
  final _navigationService = locator<NavigatorService>();

  Uint8List? bytes;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  PersonalDataForm? user;
  ITicketState state = ITicketState();

  Future<void> getProfile(userId) async {
    state = LoadingTicketState();
    notifyListeners();
    user = await _fService.getCurrentUser(userId);
    user.isDefinedAndNotNull
        ? state = SuccessTicketState()
        : state = FailureTicketState();
    notifyListeners();
  }

  Future<void> downloadTicket() async {
    // getPdf(bytes!);
    bytes = await screenshotController.capture();
    notifyListeners();
    String resUrl = await uploadImage(bytes!,user!.uuid!);
    html.AnchorElement anchorElement = html.AnchorElement(href: resUrl);
    anchorElement.download = "Tickets/Doc2023${user!.uuid}";
    anchorElement.click();
    _navigationService.replace(AppRoutes.generateQrPage);

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


  ///convert bytes to file
  // io.File createFileFromBytes(Uint8List bytes) => io.File.fromRawPath(bytes);

  // Future uploadImageToFirebase(File value,String userID) async {
  //   String fileName = value.path;
  //   final storageRef = FirebaseStorage.instance.ref('uploads');
  //   final mountainsRef = storageRef.child("$userID/$fileName");
  //   final mountainImagesRef = storageRef.child("$userID/$fileName");
  //   assert(mountainsRef.name == mountainImagesRef.name);
  //   assert(mountainsRef.fullPath != mountainImagesRef.fullPath);
  //   // Directory appDocDir = await getApplicationDocumentsDirectory();
  //   // String filePath = '${appDocDir.absolute}/$fileName';
  //   // File file = File(filePath);
  //   await mountainsRef.putFile(value);
  //   await mountainsRef.getDownloadURL();
  //
  //   // final firebaseStorageRef =
  //   // FirebaseStorage.instance.ref().child('/$fileName');
  //   // StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   // taskSnapshot.ref.getDownloadURL().then(
  //   //       (value) => print("Done: $value"),
  //   // );
  // }
  //
  // Future<void> getPdf(Uint8List screenShot) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (context) {
  //         return pw.Center(
  //           child: pw.Image(
  //             pw.MemoryImage(screenShot),
  //             fit: pw.BoxFit.contain,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   final output = File('Download/ticker${user!.uuid}');
  //   await output.writeAsBytes(await pdf.save());
  //   print(output.path);
  // }

  Future<String> uploadImage(Uint8List file,String id) async {

    Reference ref = FirebaseStorage.instance.ref().child('Tickets');
    ref = ref.child("Doc2023$id");

    UploadTask uploadTask = ref.putData(
      file,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
