import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import '../app.dart';


signOut(ApplicationState authNotifier, BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  authNotifier.setUser(null);
  print('log out');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    }),
  );
}

initializeCurrentUser(AuthNotifier authNotifier, BuildContext context) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  if (firebaseUser != null) {
    authNotifier.setUser(firebaseUser);
    await getUserDetails(authNotifier);
  }
}
