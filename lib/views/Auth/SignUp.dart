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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logo
                Image.asset(
                  "assets/images/auth_logo.png",
                  width: 200,
                ),

                SizedBox(
                  height: 20,
                ),

                Column(
                  children: [
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

                SizedBox(
                  height: 55,
                ),

                Text(
                  "Already Have an Account?",
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),

                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Login();
                      }));
                    },
                    child: const Text(
                      "Login",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
