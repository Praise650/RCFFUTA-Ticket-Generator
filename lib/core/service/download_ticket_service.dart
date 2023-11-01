import 'package:flutter/material.dart';

abstract class DownloadTicketService{
  Future<void> captureAndSavePng({required GlobalKey qrkey});
  Future<void> convertToPdf(String id);
  Future<void> downloadTicketToDevice({required String id});
  Future<void> uploadFileToStorage(String id,String userId);
}