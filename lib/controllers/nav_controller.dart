import 'package:ewallet/views/Auth/Login.dart';
import 'package:ewallet/views/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt currentValue = RxInt(0);

  List<Widget> pages = [
    const Home(),
    const Center(
      child: Text("Groups"),
    ),
    const Center(
      child: Text("Wallet"),
    ),
    Center(
      child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Get.snackbar("Success", "Successfully Logout");
            Get.offAll(() => Login());
          },
          child: const Text("Logout")),
    ),
  ];

  changeValue(int index) {
    currentValue.value = index;
    update();
  }
}
