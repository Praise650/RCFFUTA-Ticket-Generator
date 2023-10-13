import 'personal_data.dart';

abstract class IResponse {}

class SuccessResponse extends IResponse {
  PersonalDataForm user;
  SuccessResponse({
    required this.user,
  });
}

class FailureResponse extends IResponse {
  String message;
  FailureResponse({
    required this.message,
  });
}
