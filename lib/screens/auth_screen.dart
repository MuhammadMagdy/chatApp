import 'dart:io';

import 'file:///C:/Users/Magdy/AndroidStudioProjects/chat_app/lib/widgets/auth/form_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  UserCredential userCredential;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      File image, bool isLogin, BuildContext ctx) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(userCredential.user.uid + '.jpg');

        await ref.putFile(image);

        final url = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'email': email,
          'username': username,
          'password': password,
          'image_url':url,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Error Occurred';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: FormAuth(_submitAuthForm, isLoading),
    );
  }
}
