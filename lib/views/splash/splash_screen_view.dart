import 'dart:async';
import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:ewallet/views/welcomeView/welcome_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  //grab the current user
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // 3 second break for splash screen.
    Timer(const Duration(seconds: 3), () {
      if (user == null) {
        //Login page
        Get.offAll(() => WelcomeView());
        return;
      }
      //Nav view page
      Get.offAll(() => NavView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primary,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Image.asset(
                'assets/images/logo.png',
                width: 96,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "UpayApp",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              )
            ])),
      ),
    );
  }
}
