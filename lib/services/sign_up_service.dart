import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/views/profileSetUpView/profile_setup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SignUpService {
  createAccount({context, email, password}) async {
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
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        // Create an user Collection
        await FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user!.uid)
            .set({"email": email});

        //Navigate to ProfileSetupView
        Get.offAll(() => ProfileSetupView(
              emailAddress: email,
            ));
        Get.snackbar("Contgratulations!", "Successfully Sign Up");

        return "Success";
      }

      return;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'weak-password') {
        showAlert(
            title: 'Error',
            text: "The password provided is too weak.",
            context: context);
        return;
      } else if (e.code == 'email-already-in-use') {
        showAlert(
            title: 'Error',
            text: "The account already exists for that email.",
            context: context);

        return;
      } else {
        showAlert(
            title: 'Error', text: "Account Creation Failed", context: context);
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

  showAlert({required String title, required String text, required context}) {
    Get.snackbar(title, text);
  }
}
