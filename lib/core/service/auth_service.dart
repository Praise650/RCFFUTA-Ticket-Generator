import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthService {
  Future<User?> login({String? email, String? password});
  Future<User?> register({String? email, String? password});
  Future<void> signOut();
}
