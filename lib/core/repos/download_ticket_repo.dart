// ignore_for_file: avoid_print
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:js_interop';

import '../../routes/app_routes.dart';
import '../service/download_ticket_service.dart';
import '../service/navigator_service.dart';
import '../../app/locator.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DownloadTicketRepo implements DownloadTicketService {
  final _navigationService = locator<NavigatorService>();
  
  late Uint8List _doc;

  @override
  Future<void> downloadTicketToDevice(
      {required String id}) async {
    final blob = html.Blob([_doc],'application.pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement..href = url..style.display = 'none'..download ='DOC$id.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
    _navigationService.replace(AppRoutes.generateQrPage);

    debugPrint("phewwww");

  }

  Future<String> uploadFileToStorage(String id) async {
    Reference ref = FirebaseStorage.instance.ref().child('Tickets');
    ref = ref.child("Doc$id");

    UploadTask uploadTask = ref.putData(
      _doc,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadTicket(Uint8List? bytes,String id) async {
    try {
      print("Uploading ticket");
      print("User Id: $id} and ${bytes.runtimeType}");
      
      print("Upload successful");
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> captureAndSavePng(GlobalKey qrkey) async{
    RenderRepaintBoundary boundary = qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
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
    _doc = byteData!.buffer.asUint8List();
    _convertToPdf();
  }

  void _convertToPdf() async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(_doc);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          ); // Center
        },
      ),
    );
    _doc = await pdf.save();
  }
}
