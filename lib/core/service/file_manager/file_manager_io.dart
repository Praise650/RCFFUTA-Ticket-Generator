// // ignore_for_file: avoid_print
//
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../app/locator.dart';
// import '../firestore_service.dart';
// import 'file_manager_interface.dart';
//
// class FileManagerIO implements FileManagerInterface {
//   final _fsService= locator<FireStoreService>();
//
//   @override
//   Future<void> uploadFileUrl({required String uploadUrl}) async {
//     final result = await FilePicker.platform.pickFiles();
//     final path = result?.files.single.path;
//     if (path == null) return;
//     final bytes = await File(path).readAsBytes();
//     await http.post(Uri.parse(uploadUrl), body: bytes);
//   }
//
//   @override
//   Future<String?> uploadFileToStorage(
//       {required Uint8List doc, required String id,required String userId}) async {
//     if (doc.isEmpty) return null;
//     String docName = 'DOC$id'.toUpperCase();
//     String docNameExt = '$docName.pdf';
//     Reference ref = FirebaseStorage.instance.ref().child('Tickets');
//     ref = ref.child(docNameExt);
//
//     UploadTask uploadTask = ref.putData(
//       doc,
//       SettableMetadata(contentType: 'application/pdf'),
//     );
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     await _fsService.updateImageUrl(userId: userId, data: {'imageUrl': downloadUrl});
//     return downloadUrl;
//   }
//
//   @override
//   Future<void> downloadFileFromUrl(
//       {required String url, required String filename}) async {
//     // final uri = Uri.parse(url);
//     // var response = await http.get(uri);
//     // final path = await FilePicker.platform.saveFile(fileName: filename);
//     // if (path == null) return;
//     // final saveFile = File(path);
//     // await saveFile.writeAsBytes(response.bodyBytes);
//     bool hasPermission = await _requestWritePermission();
//     if (!hasPermission) return;
//
//     Dio dio = Dio();
//     var dir = await getApplicationDocumentsDirectory();
//
//     // You should put the name you want for the file here.
//     // Take in account the extension.
//     String fileName = filename;
//     await dio.download(url, "${dir.path}/$fileName");
//     OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
//   }
//
//   // @override
//   // Future<void> downloadLocalFile(
//   //     {required Uint8List pdf, required String filename}) async {
//   //   final path = await FilePicker.platform.saveFile(fileName: filename);
//   //   if (path == null) return;
//   //   final saveFile = File(path);
//   //   await saveFile.writeAsBytes(pdf);
//   //   print("Phewww");
//   // }
//
//   Future<bool> _requestWritePermission() async {
//     await Permission.storage.request();
//     return await Permission.storage.request().isGranted;
//   }
// }
