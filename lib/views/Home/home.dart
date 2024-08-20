import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/customHomeItem.dart';
import 'package:ewallet/globals/custom_list.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/activity/activity.dart';
import 'package:ewallet/views/contactsView/contacts_view.dart';
import 'package:ewallet/views/profileSetUpView/profile_setup_view.dart';
import 'package:ewallet/views/sent_money/sent_money_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //user
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Column(
        children: [
          //------------------------Header-----------------------------------
          Container(
            height: size.height * .35,
            width: size.width,
            decoration: BoxDecoration(
                color: Appcolor.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                )),
            child: Padding(
                padding: const EdgeInsets.all(20.00),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(user!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final userData = snapshot.data?.data();

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 190, 186, 186),
                          highlightColor:
                              const Color.fromARGB(255, 255, 251, 251),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                width: size.width * .4,
                                color: Colors.white,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: size.width * .7,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/logo.png",
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () => Get.to(() => ProfileSetupView(
                                        emailAddress: FirebaseAuth
                                            .instance.currentUser!.email,
                                      )),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.white, width: 2.0),
                                        image: DecorationImage(
                                            image: userData!["Profile Pic"] !=
                                                    null
                                                ? NetworkImage(
                                                    userData["Profile Pic"])
                                                : const NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu9mCh1J0Pulu5JXw8cpYkMsCiyFJavo-esQ&usqp=CAU"),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Hello ${userData["Full Name"]}",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$ ${userData["Balance"]}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Your Balance",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )
                          ],
                        );
                      }
                    })),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------------------Buttons---------------------------
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Get.to(() => ContactsView(
                                appbarTitle: "Send Money",
                              )),
                          child: const CustomHomeItem(
                            title: "Sent\nMoney",
                            icon: Icons.send,
                          ),
                        ),
                        const SizedBox(
                          width: 20.00,
                        ),
                        CustomHomeItem(
                          title: "Save\nMoney",
                          icon: Icons.monetization_on,
                          bgColor: Colors.white,
                          itemColor: Appcolor.primary,
                        )
                      ],
                    )

                    //------------------------Activities-----------------------------
                    ,
                    const SizedBox(
                      height: 20.00,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Activity",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () => Get.to(() => ActivityView()),
                          child: const Text("See All",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),

                    //----------------------activity list-----------------------------
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("history")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Center(
                                  child: SpinKitCircle(
                                color: Colors.black,
                              )),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text("No Transaction History Found"));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: ((context, index) {
                                  final data = snapshot.data?.docs[index];
                                  final bool isMe =
                                      data?["Sender Email"] == user.email;

                                  DateTime trxTime =
                                      (data?["Time"] as Timestamp).toDate();

                                  final formatedTime =
                                      DateFormat.yMMMEd().format(trxTime);
                                  print(isMe);
                                  //  print("${data?["Receiver"][0]}");
                                  return isMe
                                      ? CustomList(
                                          price: "\$${data?["amount"]}",
                                          subTitle: formatedTime,
                                          title: "${data?["Receiver"]}",
                                          itemColor: Colors.red,
                                          icon: CircleAvatar(
                                            child: Text(""),
                                          ),
                                        )
                                      : SizedBox();
                                }));
                          }
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
