import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/views/Auth/Login.dart';
import 'package:ewallet/views/setup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUP extends StatelessWidget {
  SignUP({Key? key}) : super(key: key);

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
                height: 20.00,
              ),
              //-----------------Input Fields---------------------
              Column(
                children: [
                  //-------------------- Logo-------------------
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
                  CustomField(
                    title: "Reenter your Password",
                    secure: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                ],
              ),

              //------------------Login Button----------------------

              Column(
                children: [
                  CustomButton(
                    title: "Sign Up",
                    ontap: () async {
                      try {
                        if (emailCotroller.text == "" ||
                            passwordController.text == "") {
                          Get.snackbar("Error", "Fields cant be empty.");
                          return;
                        }

                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailCotroller.text,
                                password: passwordController.text);

                        Get.offAll(() => SetupView(
                              emailAddress: emailCotroller.text,
                            ));
                        Get.snackbar("success", "Successfully Signup");
                      } on FirebaseAuthException catch (e) {
                        print(e);
                        Get.snackbar("Error", e.message!);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(Login());
                      },
                      child: const Text(
                        "Already Have an Account?",
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
