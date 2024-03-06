import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends StatelessWidget {
  final receiverEmail;
  final amountSend;
  const SuccessView({Key? key, this.amountSend, this.receiverEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(55.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                "\$${amountSend} USD",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                height: 30,
              ),
              CustomButton(
                title: "Done",
                ontap: () => Get.to(() => NavView()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
