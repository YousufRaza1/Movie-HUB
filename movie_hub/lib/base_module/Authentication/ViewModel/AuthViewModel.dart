import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../View/HomeScreen.dart';
import '../../buttom_navigation_screen.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<bool> isLoading = false.obs;

  Future<void> resetPassword(String email, BuildContext context) async {
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;
      print('success');
    } catch (e) {
      print('fail');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    isLoading.value = true;
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    isLoading.value = false;
    if (gUser == null) return;
    GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final cradential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    final userCradential = await _auth.signInWithCredential(cradential);
    if (userCradential != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BottomNavScreen()), // Replace with your target screen
      );
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String pass, BuildContext context) async {
    isLoading.value = true;
    try {
      print('started');
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print('ended');
      print(credential);

      // Navigate to the new screen if the user is successfully created
      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavScreen()), // Replace with your target screen
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('error Firebase.....${e}');
    }
    isLoading.value = false;
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    isLoading.value = true;
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Success login');


      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavScreen()), // Replace with your target screen
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Incorrect password provided.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}
