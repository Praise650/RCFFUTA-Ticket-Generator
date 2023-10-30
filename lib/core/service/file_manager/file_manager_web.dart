// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart' as html;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../../app/locator.dart';
import '../firestore_service.dart';
import 'file_manager_interface.dart';

class FileManagerWeb implements FileManagerInterface{
  final _fsService= locator<FireStoreService>();
  @override
  Future<void> uploadFileUrl({required String uploadUrl}) async {
    final result = await FilePicker.platform.pickFiles();
    final bytes = result?.files.single.bytes;
    if(bytes == null) return;
    await http.post(Uri.parse(uploadUrl),body: bytes);
  }

  @override
  Future<String?> uploadFileToStorage({required Uint8List doc, required String id,required String userId}) async{
    try {
      String docName = 'DOC$id'.toUpperCase();
      String docNameExt = '$docName.pdf';
      Reference ref = FirebaseStorage.instance.ref().child('Tickets');
      ref = ref.child(docNameExt);

      UploadTask uploadTask = ref.putData(
        doc,
        SettableMetadata(contentType: 'application/pdf'),
      );
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await _fsService.updateMemberInformation({'imageUrl': downloadUrl},userId);
      return downloadUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // @override
  // Future<void> downloadFileFromUrl({required String url,required String filename}) async{
  //   final uri = Uri.parse(url);
  //   var response = await http.get(uri,headers: {
  //   "Access-Control-Allow-Origin": "*",
  //   'Content-Type': 'application/json',
  //   'Accept': '*/*'
  //   },
  //   );
  //   final blob = html.Blob([response.bodyBytes]);
  //   final anchorElement = html.AnchorElement(
  //     href: html.Url.createObjectUrlFromBlob(blob).toString(),
  //   )..setAttribute('download', filename);
  //   html.document.body!.children.add(anchorElement);
  //   anchorElement.click();
  //   html.document.body!.children.remove(anchorElement);
  //   print(response.bodyBytes.length);
  // }

  @override
  Future<void> downloadLocalFile({required Uint8List pdf,required String filename}) async {
    final blob = html.Blob([pdf], 'application.pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = filename;
    html.document.body!.children.add(anchor);
    anchor.click();
    print("phewwww");
  }


}