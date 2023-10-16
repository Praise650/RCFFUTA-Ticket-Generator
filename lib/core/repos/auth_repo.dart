import 'package:firebase_auth/firebase_auth.dart';

import '../../core/service/navigator_service.dart';
import '../../core/service/auth_service.dart';
import '../errors/firebase_auth_error.dart';
import '../service/firestore_service.dart';
import '../../routes/app_routes.dart';
import '../../app/locator.dart';

class AuthRepo implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fsService = locator<FireStoreService>();
  final _navigationService = locator<NavigatorService>();

  @override
  Future<User?> login({String? email, String? password}) async {
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
          final userDataCreated = await _fsService.checkToLogin(user.uid);
          userDataCreated != null
              ? _navigationService.navigateToDownloadQrPage(user.uid)
              : _navigationService.navigateTo(AppRoutes.listUserPage);
          print("Checking database for user");
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
          print(user.email);
          return user;
        } else {
          throw Exception('Could not find user');
        }
      }
    } on FirebaseAuthError catch (e) {
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
  Future<User?> register({
    String? email,
    String? password,
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
