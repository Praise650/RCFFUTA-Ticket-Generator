import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'file_manager_interface.dart';

class FileManager implements FileManagerInterface{
  @override
  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;
    if(path == null) return;
    final bytes = await File(path).readAsBytes();
    debugPrint("Image uploaded successfully");
  }

  @override
  Future<void> downloadFile(String url,String filename) async {
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    final path = await FilePicker.platform.saveFile(fileName: filename);
    if(path == null) return;
    final saveFile = File(path);
    await saveFile.writeAsBytes(response.bodyBytes);
    debugPrint(path);
  }
}