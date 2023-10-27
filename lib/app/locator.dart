import 'package:get_it/get_it.dart';
import '../core/service/download_ticket_service.dart';
import '../core/repos/download_ticket_repo.dart';
import '../core/service/navigator_service.dart';
import '../core/service/firestore_service.dart';
import '../core/service/auth_service.dart';
import '../core/repos/auth_repo.dart';
import '../core/repos/user_repo.dart';

final locator = GetIt.instance;

Future<void>  setupLocator() async{
  locator.registerLazySingleton<AuthService>(() => AuthRepo());
  locator.registerLazySingleton<FireStoreService>(() => UserRepo());
  locator.registerLazySingleton<DownloadTicketService>(() => DownloadTicketRepo());
  locator.registerLazySingleton(()=>NavigatorService());
}
