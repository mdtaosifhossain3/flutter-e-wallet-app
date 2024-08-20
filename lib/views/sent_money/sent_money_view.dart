import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/custom_appbar.dart';
import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/views/sent_money/amount_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentMoneyView extends StatelessWidget {
  SentMoneyView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Sent Money", arrorw: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomField(
              title: "Enter Email Address",
              controller: emailController,
            ),
            CustomButton(
              title: "Send Money",
              ontap: () async {
                try {
                  final doc = await FirebaseFirestore.instance
                      .collection("user")
                      .doc(emailController.text)
                      .get();
                  final sender = await FirebaseFirestore.instance
                      .collection("user")
                      .doc(user!.email)
                      .get();
                  print(sender.data());

                  final receiverData = doc.data();
                  if (receiverData == null) {
                    Get.snackbar("Error", "User Not Exsist");
                  } else {
                    if (user!.email == emailController.text) {
                      Get.snackbar("Error", "You cant sent money yourself");
                    } else {
                      Get.off(() => AmountView(
                          receiverData: receiverData,
                          senderData: sender.data()));
                    }
                  }
                } catch (e) {
                  print(e);
                }
                // try {
                //   final doc = await FirebaseFirestore.instance
                //       .collection("user")
                //       .doc(emailController.text)
                //       .get();
                //   final userData = doc.data();
                //   if (userData == null) {
                //     Get.snackbar("Error", "User Not Exsist");
                //   } else {
                //     if (user!.email == userData["Email"]) {
                //       Get.snackbar("Error", "You cant sent money yourself");
                //     }
                //     Get.off(() => AmountView());
                //   }
                // } on FirebaseException catch (e) {
                //   Get.snackbar("Error", e.message!);
                // }
              },
            )
          ],
        ),
      ),
    );
  }
}
