import 'dart:typed_data';

abstract interface class FileManagerInterface{
  Future<void> uploadFileUrl({required String uploadUrl});
  Future<String?> uploadFileToStorage({required Uint8List doc, required String id,required String userId});
  // Future<void> downloadFileFromUrl({required String url,required String filename});
  Future<void> downloadLocalFile({required Uint8List pdf,required String filename});
}