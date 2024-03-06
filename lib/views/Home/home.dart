import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/customHomeItem.dart';
import 'package:ewallet/globals/custom_list.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/activity/activity.dart';
import 'package:ewallet/views/sent_money/sent_money_view.dart';
import 'package:ewallet/views/setup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            decoration: const BoxDecoration(
                color: Color(0xff114da4),
                borderRadius: BorderRadius.only(
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
                      final userData = snapshot.data!.data();

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
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
                                  onTap: () => Get.to(() => SetupView(
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
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj7j9IDpZsbq4HghrNPneZustxYupRgrt0oQ&usqp=CAU"),
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
                                      fontWeight: FontWeight.w100),
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
                          onTap: () => Get.to(() => SentMoneyView()),
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
                    const SizedBox(
                      height: 10,
                    ),

                    //----------------------activity list-----------------------------
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("history")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.00),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: ((context, index) {
                                  final data = snapshot.data!.docs[index];
                                  final bool isMe =
                                      data["Sender Email"] == user.email;

                                  DateTime trxTime =
                                      (data["Time"] as Timestamp).toDate();

                                  final formatedTime =
                                      DateFormat.yMMMEd().format(trxTime);
                                  print(isMe);

                                  return isMe
                                      ? CustomList(
                                          price: "\$${data["amount"]}",
                                          subTitle: formatedTime,
                                          title: "${data["Receiver"]}",
                                          itemColor: Colors.red,
                                          icon: CircleAvatar(
                                            child:
                                                Text("${data["Receiver"][0]}"),
                                          ),
                                        )
                                      : const SizedBox();
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
