import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/views/Auth/SignUp.dart';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailCotroller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 70.00,
              ),
              //-----------------Input Fields---------------------
              Column(
                children: [
                  // ------------------------Logo---------------------
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 76,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "UpayApp",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  CustomField(
                    title: "Enter your Email Address",
                    controller: emailCotroller,
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  CustomField(
                    title: "Enter your Password",
                    secure: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              //------------------Login Button----------------------
              Column(
                children: [
                  CustomButton(
                    title: "Login",
                    ontap: () async {
                      try {
                        if (emailCotroller.text == "" ||
                            passwordController.text == "") {
                          Get.snackbar("Error", "Fields cant be empty.");
                          return;
                        }
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailCotroller.text,
                            password: passwordController.text);

                        Get.offAll(() => NavView());
                        Get.snackbar("Contgratulations!", "Successfully Login");
                      } on FirebaseAuthException catch (e) {
                        Get.snackbar("Error", e.message!);
                        print(e);
                      }
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  //---------------Others -------------------------

                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SignUP();
                        }));
                      },
                      child: const Text(
                        "Having Trouble Logging In?",
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
