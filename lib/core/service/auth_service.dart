import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/personal_data.dart';


abstract class AuthService {
  Future<PersonalDataForm?> login({String? email, String? password});
  Future<PersonalDataForm?> loginAsAdmin({String? email, String? password});
  Future<User?> register({String? email, String? password});
  Future<void> signOut();
}
