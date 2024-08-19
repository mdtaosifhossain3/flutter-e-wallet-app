import 'dart:io';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginService {
  login({context, email, password}) async {
    //Loading Effect
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SpinKitThreeInOut(
                    color: Colors.black,
                  ),
                ]),
          );
        });
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        //Navigate to NavView
        Get.to(() => NavView());
        Get.snackbar("Contgratulations!", "Successfully Login");

        return 'Success';
      }

      return;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        showAlert(
            title: 'Error',
            text: "No user found for that email.",
            context: context);
        return;
      } else if (e.code == 'wrong-password') {
        showAlert(
            title: 'Error',
            text: "Wrong password provided for that user.",
            context: context);

        return;
      } else {
        showAlert(title: 'Error', text: "Login Failed", context: context);
        // ignore: avoid_print
        return print(e.message);
      }
    } on SocketException catch (e) {
      Navigator.pop(context);
      showAlert(
          title: 'Time Out', text: e.message.toString(), context: context);
    } catch (e) {
      Navigator.pop(context);
      showAlert(
          title: 'Something Went Wrong', text: e.toString(), context: context);
    }
  }

  showAlert({required String title, required String text, context}) {
    Get.snackbar(title, text);
  }
}
