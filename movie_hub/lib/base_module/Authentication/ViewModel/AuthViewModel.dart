import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../buttom_navigation_screen.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<String> userEmail = "".obs;
  Rx<String> password = "".obs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> isValidForPassword = false.obs;
  Rx<bool> isValidForEmail = false.obs;

  Future<void> resetPassword(String email, BuildContext context) async {
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;
      // showToast(context, 'check your email');
    } catch (e) {
      isLoading.value = false;
      showToast('Error: ${e}');
      // showToast(context, '${e}');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    isLoading.value = true;
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
       showToast('Something went wrong');
      return ;
    }

    GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final cradential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    final userCradential = await _auth.signInWithCredential(cradential);
    isLoading.value = false;
    if (userCradential != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BottomNavScreen()), // Replace with your target screen
      );
    } else {
      isLoading.value = false;
      showToast('Something went wrong');
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
      isLoading.value = false;

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
      isLoading.value = false;
      showToast('${e.message}');
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

    } catch (e) {
      isLoading.value = false;
      showToast('${e}');
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

      isLoading.value = false;


      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavScreen()), // Replace with your target screen
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Incorrect password provided.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error: ${e.message}');
      }
      showToast('Error: ${e.message}');
    } catch (e) {
      isLoading.value = false;
      showToast('Error: ${e.toString()}');
      print(e);
    }

  }

  void isValidEmail(String email) {
    userEmail.value = email;
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    isValidForEmail.value = regex.hasMatch(email);
  }

  void isValidPassword(String password, {int minLength = 4}) {
    this.password.value = password;
    isValidForPassword.value = password.length >= minLength;
  }

  void showToast(String message) {
    Get.snackbar(
      'Error', // Title of the snackbar
      message, // Message to display
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }




}
