// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import '../../core/service/navigator_service.dart';
import '../../core/service/auth_service.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_response.dart';
import '../errors/firebase_auth_error.dart';
import '../service/firestore_service.dart';
import '../../app/locator.dart';

class AuthRepo implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fsService = locator<FireStoreService>();
  final _navigationService = locator<NavigatorService>();

  @override
  Future<void> login({String? email, String? password}) async {
    User? user;
    try {
      if (email != null && password != null) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        if (user != null) {
          print("Logging in: ${user.uid} and ${user.email}");
          final userDataCreated = await _fsService.checkToLogin(user.uid);
          print(userDataCreated.toString());
          if (userDataCreated != null && userDataCreated.id == user.uid) {
            print(userDataCreated.email);
            AppResponse.success("Login Successful");
            _navigationService.navigateToDownloadQrPage(args:userDataCreated.id!);
          } else {
            print('Could not find user');
            AppResponse.error("Invalid data: Could not find user");
            return;
          }
        } else {
          AppResponse.error("Failed, could not find user");
          return;
        }
      } else return;
    } on FirebaseAuthError catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        AppResponse.error("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        AppResponse.error("The account already exists for that email.");
      } else if (e.code == 'user-not-found') {
        AppResponse.error("There is no user record corresponding to the email entered.");
        throw ('There is no user record corresponding to the email entered.');
      } else if (e.code == 'invalid-email') {
        AppResponse.error("The email address is badly formatted!");
        throw ('The email address is badly formatted!');
      } else if (e.code == "network-request-failed") {
        AppResponse.error("The password provided is too weak.");
        throw ('The password provided is too weak.');
      } else if (e.code == "wrong-password") {
        AppResponse.error("The password provided is incorrect.");
        throw ('The password provided is incorrect.');
      }
    } catch (e) {
      print(e);
      AppResponse.error('Failed, please check details and try again');
      return;
    }
    return;
  }

  @override
  Future<void> loginAsAdmin(
      {String? email, String? password}) async {
    User? user;
    try {
      if (email != null && password != null) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        if (user != null) {
          print("Logging in: ${user.uid}");
          final userDataCreated = await _fsService.checkAdminToLogin(user.uid);
          print(userDataCreated.toString());
          if (userDataCreated != null && userDataCreated.id == user.uid) {
            print(userDataCreated.email);
            AppResponse.success("Login Successful");
            _navigationService.replace(AppRoutes.listUserPage);
          } else {
            print('Could not find user');
            AppResponse.error("Invalid data: Could not find user");
            return;
          }
        } else {
          AppResponse.error("Failed, could not find user");
          return;
        }
          /// create array to save admin login session using setOptions on firebase
          // DateTime now = DateTime.now();
          // final snapshot =
          //     await firestoreService.collection('').doc(currentUser.uid).get();
          // final saveTimeStamp =
          // Map<String, dynamic> jsonData = {
          //   "timeStamp": FieldValue.arrayUnion(
          //     [DateFormatter.dateFormatter(now)],
          //   ),
          // };
          //   await _fsService.uploadMemberInformation(jsonData, user.uid);
          // if (snapshot.exists) {
          //   print("Login successful");
          //   // firestoreService.setUser(snapshot.data() as Map<String, dynamic>);
          // }
      } else return;
    } on FirebaseAuthError catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        AppResponse.error("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        AppResponse.error("The account already exists for that email.");
      } else if (e.code == 'user-not-found') {
        AppResponse.error("There is no user record corresponding to the email entered.");
        throw ('There is no user record corresponding to the email entered.');
      } else if (e.code == 'invalid-email') {
        AppResponse.error("The email address is badly formatted!");
        throw ('The email address is badly formatted!');
      } else if (e.code == "network-request-failed") {
        AppResponse.error("The password provided is too weak.");
        throw ('The password provided is too weak.');
      } else if (e.code == "wrong-password") {
        AppResponse.error("The password provided is incorrect.");
        throw ('The password provided is incorrect.');
      }
    } catch (e) {
      print(e);
      AppResponse.error('Failed, please check details and try again');
    }
    return;
  }

  @override
  Future<User?> register({
    String? email,
    String? password
  }) async {
    User? user;
    try {
      if (email != null && password != null) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        if (user != null) {
          AppResponse.success("Login Successful");
          // if (snapshot.exists) {
          //   print("Login successful");
          //   // firestoreService.setUser(snapshot.data() as Map<String, dynamic>);
          // }
          return user;
        } else {
          throw Exception('Could not find user');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        throw ('There is no user record corresponding to the email entered.');
      } else if (e.code == 'invalid-email') {
        throw ('The email address is badly formatted!');
      } else if (e.code == "network-request-failed") {
        throw ('The password provided is too weak.');
      } else if (e.code == "wrong-password") {
        throw ('The password provided is incorrect.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Future<void> signOut() async {
    _auth.signOut();
    print("Signed Out");
  }
}
