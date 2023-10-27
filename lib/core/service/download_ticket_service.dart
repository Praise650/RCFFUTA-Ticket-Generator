import 'dart:typed_data';

abstract class DownloadTicketService{
  Future<void> downloadTicketToDevice({required String id});
  Future<void> captureAndSavePng();
}