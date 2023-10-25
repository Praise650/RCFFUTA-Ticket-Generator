import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

import '../../routes/app_routes.dart';
import '../service/download_qr_service.dart';
import '../service/navigator_service.dart';
import '../../app/locator.dart';

class DownloadTicketRepo implements DownloadTicketService {
  final _navigationService = locator<NavigatorService>();
  @override
  Future<void> downloadTicket(
      {required Uint8List bytes, required String id}) async {
    String resUrl = await uploadImage(bytes, id);
    html.AnchorElement anchorElement = html.AnchorElement(href: resUrl);
    anchorElement.download = "Tickets/Doc$id}";
    anchorElement.click();
    _navigationService.replace(AppRoutes.generateQrPage);
  }

  Future<String> uploadImage(Uint8List file, String id) async {
    Reference ref = FirebaseStorage.instance.ref().child('Tickets');
    ref = ref.child("Doc$id");

    UploadTask uploadTask = ref.putData(
      file,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> captureAndSavePng() {
    throw UnimplementedError();
  }

  ///convert bytes to file
// io.File createFileFromBytes(Uint8List bytes) => io.File.fromRawPath(bytes);

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
}
