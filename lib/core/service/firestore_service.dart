import '../models/personal_data.dart';

abstract class FireStoreService {
  Future<List<PersonalDataForm>> getMembersCollection();
  Future<PersonalDataForm> getCurrentUser(userId);
  Future<void> uploadMemberInformation(Map<String, dynamic> jsonData, uid);
  Future<void> saveDataAsJson(List<Map<String, String>> list);
  Future<bool> checkUserIsCreated(String userId);
}
