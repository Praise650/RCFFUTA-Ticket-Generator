import 'package:get_it/get_it.dart';
import 'package:rcf_attendance_generator/core/repos/user_repo.dart';
import '../core/repos/auth_repo.dart';
import '../core/service/auth_service.dart';
import '../core/service/firestore_service.dart';

final locator = GetIt.instance;

Future<void>  setupLocator() async{
  locator.registerLazySingleton<AuthService>(() => AuthRepo());
  locator.registerLazySingleton<FireStoreService>(() => UserRepo());
  // locator.registerSingleton(AuthService);
}
