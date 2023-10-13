import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcf_attendance_generator/core/service/auth_service.dart';

import '../../app/locator.dart';
import '../../utils/date_formatter.dart';
import '../errors/firebase_auth_error.dart';
import '../service/firestore_service.dart';

class AuthRepo  implements AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fsService = locator<FireStoreService>();

  @override
  Future<User?> login({String? email, String? password}) async {
    User? user;
    //TODO: implement checking db for current user
    final userDataCreated = await _fsService.checkUserIsCreated(user!.uid);
    try {
      if (email != null && password != null) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        if (user != null && userDataCreated == true) {
          DateTime now = DateTime.now();
            /// create array to save admin login session using setOptions on firebase
            // final snapshot =
            //     await firestoreService.collection('').doc(currentUser.uid).get();
            // final saveTimeStamp =
          Map<String, dynamic> jsonData = {
            "timeStamp": FieldValue.arrayUnion(
              [DateFormatter.dateFormatter(now)],
            ),
          };
            await _fsService.uploadMemberInformation(jsonData, user.uid);
            // if (snapshot.exists) {
            //   print("Login successful");
            //   // firestoreService.setUser(snapshot.data() as Map<String, dynamic>);
            // }

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
  Future<User?> register({String? email, String? password,}) async{
    User? user;
    try {
      if (email != null && password != null) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
  Future<void> signOut() async{
    _auth.signOut();
    print("Signed Out");
  }
}
