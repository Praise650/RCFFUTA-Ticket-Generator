import 'dart:typed_data';

abstract class DownloadTicketService{
  Future<void> downloadTicket({required Uint8List bytes, required String id});
  Future<void> captureAndSavePng();
}