import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends StatelessWidget {
  final dynamic receiverEmail;
  final dynamic amountSend;
  const SuccessView({Key? key, this.amountSend, this.receiverEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(55.0),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    const Text(
                      "Success!",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "\$$amountSend USD",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "has been sent to $receiverEmail from your wallet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      title: "Done",
                      ontap: () => Get.offAll(NavView()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
