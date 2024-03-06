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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ------------------------Logo---------------------
                Image.asset(
                  "assets/images/auth_logo.png",
                  width: 200,
                ),

                //-----------------Input Fields---------------------
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

                const SizedBox(
                  height: 25,
                ),

                //------------------Login Button----------------------
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
                  height: 25,
                ),
                //---------------Others -------------------------
                Text(
                  "Having Trouble Logging In?",
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),

                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignUP();
                      }));
                    },
                    child: const Text(
                      "Sign In",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
