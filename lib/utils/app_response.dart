// import 'package:stacked_services/stacked_services.dart';
//
// import '../app/app_setup.locator.dart';
// import '../core/enums/ui_setups/snackbar_type.dart';
//
// class AppResponse {
//   static final snackbar = locator<SnackbarService>();
//
//   actionSuccessful(String message) async {
//     snackbar.showSnackbar(
//       message: message.toString(),
//       // variant: SnackbarType.success,
//       title: "Succesfull"
//     );
//     print('Error sending request!: $message');
//   }
//     actionFailed(String errorMessage) async {
//     await locator<SnackbarService>().showCustomSnackBar(
//       message: errorMessage.toString(),
//       variant: SnackbarType.error,
//       title: "Error",
//     );
//     print('Error sending request!: $errorMessage');
//   }
// }
