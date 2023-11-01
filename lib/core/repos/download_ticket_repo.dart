// ignore_for_file: avoid_print
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_response.dart';
import '../service/download_ticket_service.dart';
import '../service/file_manager/file_manager_interface.dart';
import '../service/navigator_service.dart';
import '../../app/locator.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/service/file_manager/file_manager_web.dart';

class DownloadTicketRepo implements DownloadTicketService {
  final _navigationService = locator<NavigatorService>();
  final FileManagerInterface _manager =  FileManagerWeb();

  late Uint8List _doc;

  @override
  Future<void> captureAndSavePng({required GlobalKey qrkey}) async {
    // try {
      print("Generating qr image ...");
      RenderRepaintBoundary boundary =
      qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      print("Image is being captured");
      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()
        ..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      _doc = byteData!.buffer.asUint8List();
      print("Image captured");
      //TODO: remove snackbar later
      AppResponse.success("Image captured");
      // _convertToPdf(id);
    // } catch (e) {
    //   AppResponse.error("Failed to download, Please try again");
    // }
  }

  @override
  Future<void> convertToPdf(String id) async {
    print("Converting to pdf");
    // try {
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
      // await _uploadFileToStorage(id);
      // await downloadTicketToDevice(id:id);
      print("PDF file conversion successful");
      AppResponse.success("PDF file conversion successful");
    // } catch(e){
    //   print(e);
    //   print("PDF conversion failed");
    // }
  }

  @override
  Future<void> downloadTicketToDevice({required String id}) async {
    print("Initializing local download");
    // try {
      String docName = 'DOC$id'.toUpperCase();
      String docNameExt = '$docName.pdf';
      await _manager.downloadLocalFile(filename: docNameExt, pdf: _doc).then(
            (value) {
              _navigationService.replace(
                AppRoutes.generateQrPage,
              );
              AppResponse.success("Download Successful");
            },
          // await _manager.downloadLocalFile(pdf: _doc, filename: docNameExt)
      );
    // } catch(e){
    //   print(e);
    //   print("Ticket download failed");
    // }
  }


  @override
  Future<void> uploadFileToStorage(String id,String userId) async {
    // try {
      print("Uploading ticket");
      print("User Id: $id and ${_doc.runtimeType}");
      final resUrl = await _manager.uploadFileToStorage(doc: _doc, id: id,userId:  userId);
      downloadTicketToDevice(id: id);
      print("Ticket upload successful");
      // return downloadUrl;
    // } catch (e) {
    //   print(e);
    //   print("Ticket Upload failed");
    // }
    // return null;
  }
}
