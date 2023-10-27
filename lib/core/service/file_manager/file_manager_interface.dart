abstract interface class FileManagerInterface{
  Future<void> uploadFile();
  Future<void> downloadFile(String url,String filename);
}