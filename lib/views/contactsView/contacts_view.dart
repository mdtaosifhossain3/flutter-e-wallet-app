import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/custom_appbar.dart';
import 'package:ewallet/globals/custom_list.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/amountView/amount_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ContactsView extends StatefulWidget {
  final String appbarTitle;
  const ContactsView({super.key, required this.appbarTitle});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  final emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: widget.appbarTitle),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search by Email....",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.4))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Appcolor.primary, width: 2.00))),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Colors.black,
                    ));
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final docs = snapshot.data?.docs;
                    // Filter the data based on search input
                    final filteredDocs = docs?.where((doc) {
                      final userEmail = doc["Email"] ?? '';
                      return emailController.text.isEmpty ||
                          userEmail.contains(emailController.text);
                    }).toList();

                    final filteredDataList = filteredDocs!
                        .where((item) => item["Email"] != user!.email)
                        .toList();

                    return Expanded(
                        child: ListView.builder(
                      itemCount: filteredDataList.length,
                      itemBuilder: (context, index) {
                        final data = filteredDataList[index];
                        return CustomList(
                          price: "\$${data["Balance"]}",
                          subTitle: "${data["Email"]}",
                          title: "${data["Full Name"]}",
                          ontap: () async {
                            try {
                              final doc = await FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(data["Email"])
                                  .get();
                              final sender = await FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(user!.email)
                                  .get();

                              final receiverData = doc.data();

                              Get.off(() => AmountView(
                                  amoutViewTitle: widget.appbarTitle,
                                  receiverData: receiverData,
                                  senderData: sender.data()));
                            } catch (e) {
                              if (kDebugMode) {
                                print("The Error:$e");
                              }
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
                        );
                      },
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
