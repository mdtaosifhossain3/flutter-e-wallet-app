import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/globals/custom_appbar.dart';
import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:ewallet/views/successView/success_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountView extends StatelessWidget {
  final String amoutViewTitle;
  final Map<String, dynamic>? receiverData;
  final Map<String, dynamic>? senderData;
  AmountView(
      {Key? key,
      this.receiverData,
      this.senderData,
      required this.amoutViewTitle})
      : super(key: key);

  final amountController = TextEditingController();

  transferHistory(amount) {
    FirebaseFirestore.instance.collection("history").add({
      "Sender": senderData!["Full Name"],
      "Receiver": receiverData!["Full Name"],
      "Receiver Email": receiverData!["Email"],
      "Sender Email": senderData!["Email"],
      "type": "send",
      "Time": DateTime.now(),
      "amount": amount
    }).then((value) => Get.offAll(() => SuccessView(
          amountSend: amount,
          receiverEmail: receiverData!["Email"],
        )));
  }

  transferMoney() {
    final int amount = int.parse(amountController.text);
    FirebaseFirestore.instance
        .collection("user")
        .doc(senderData!["Email"])
        .update({"Balance": senderData!["Balance"] -= amount}).then((value) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(receiverData!["Email"])
          .update({"Balance": receiverData!["Balance"] += amount});
    }).then((value) => transferHistory(amount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppbar(context: context, arrorw: true, title: amoutViewTitle),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "To: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text(receiverData!["Email"][0]),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverData!["Full Name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(receiverData!["Email"],
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.00,
                ),
                CustomField(
                  title: "Enter Amount",
                  prefixIcon: Icons.attach_money_outlined,
                  keybard: TextInputType.phone,
                  controller: amountController,
                  focusColor: Appcolor.secondary,
                  borderColor: Appcolor.secondary,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Available Balance: ${senderData!["Balance"]}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            CustomButton(
              title: "Send",
              bgColor: Appcolor.secondary,
              ontap: () {
                if (amountController.text.isEmpty) {
                  Get.snackbar("Empty", "Please Enter the amount");
                } else {
                  try {
                    final int amount = int.parse(amountController.text);
                    final int availableBalance = senderData!["Balance"];
                    // Proceed with using 'number'
                    if (amount > availableBalance) {
                      Get.snackbar("Insuficcient", "Insuficient Funds");
                    } else {
                      transferMoney();
                    }
                  } catch (e) {
                    Get.snackbar("Error", "Pleast try again later");
                    if (kDebugMode) {
                      print('Invalid number format: $e');
                    }
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
