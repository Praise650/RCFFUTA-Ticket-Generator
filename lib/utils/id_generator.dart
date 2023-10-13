import '../core/models/personal_data.dart';

class IDGenerator {
  IDGenerator();
  static String createId(String firstname, String lastname) {
    String newID = '';
    String clipFirstName = firstname;
    String clipLastName = lastname;
    String addVal = 'TRA2023';
    if (firstname.length > 3 && lastname.length > 3) {
      clipFirstName = firstname.substring(0, 2);
      clipLastName = lastname.substring(0, 3);
      newID = clipFirstName + clipLastName + addVal;
      print(newID);
    } else if (firstname.length < 3 && lastname.length > 3) {
      clipFirstName = firstname;
      clipLastName = lastname.substring(0, 3);
      newID = clipFirstName + clipLastName + addVal;
      print(newID);
    } else if (firstname.length > 3 && lastname.length < 3) {
      clipFirstName = firstname.substring(0, 2);
      clipLastName = lastname;
      newID = clipFirstName + clipLastName + addVal;
      print(newID);
    } else {
      clipFirstName = firstname;
      clipLastName = lastname;
      newID = clipFirstName + clipLastName + addVal;
      print(newID);
    }
    return newID;
  }
}
