import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

abstract class IHomeRepository {
  Future<Either<UserModel, String>> getProfile(String user);
}
