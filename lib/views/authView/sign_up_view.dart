import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/services/sign_up_service.dart';
import 'package:ewallet/views/authView/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final emailCotroller = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  final SignUpService service = SignUpService();

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
                    controller: reEnterPasswordController,
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
                      if (emailCotroller.text == '' ||
                          passwordController.text == "" ||
                          reEnterPasswordController.text == '') {
                        Get.snackbar("Error", "Fields Cant be Empty");
                      } else if (passwordController.text !=
                          reEnterPasswordController.text) {
                        Get.snackbar("Error", "Password is not matched");
                      } else {
                        service.createAccount(
                          context: context,
                          email: emailCotroller.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => LoginView());
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
