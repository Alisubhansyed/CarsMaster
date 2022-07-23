import 'package:app1/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Future<Widget> userChecker() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return Signup();
  } else {
    return Navigtor();
  }
}
