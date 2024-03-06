import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/custom_appbar.dart';
import 'package:ewallet/globals/custom_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityView extends StatelessWidget {
  ActivityView({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          title: "Activity",
          arrorw: true,
          action: [const Icon(Icons.search)]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("history").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.00),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final data = snapshot.data!.docs[index];

                    DateTime trxTime = (data["Time"] as Timestamp).toDate();

                    final formatedTime = DateFormat.yMMMEd().format(trxTime);
                    final bool isMe = data["Sender Email"] == user!.email;

                    return isMe
                        ? CustomList(
                            price: "\$${data["amount"]}",
                            subTitle: formatedTime,
                            title: "${data["Receiver"]}",
                            itemColor: Colors.red,
                            icon: CircleAvatar(
                              child: Text("${data["Receiver"][0]}"),
                            ),
                          )
                        : const SizedBox();
                  }));
            }
          }),
    );
  }
}
