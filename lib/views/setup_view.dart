import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/controllers/profile_setup_controller.dart';
import 'package:ewallet/globals/custom_appbar.dart';
import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/globals/custom_field.dart';
import 'package:ewallet/views/nav/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupView extends StatelessWidget {
  final emailAddress;
  SetupView({Key? key, this.emailAddress}) : super(key: key);

  final controller = Get.put(ProfileSetupController());

  final fullName = TextEditingController();
  final nid = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Compelete Setup"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GetBuilder<ProfileSetupController>(builder: (controller) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          //------------------Image------------------
                          controller.pickedImage == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu9mCh1J0Pulu5JXw8cpYkMsCiyFJavo-esQ&usqp=CAU"),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  radius: 60,
                                  backgroundImage:
                                      FileImage(controller.pickedImage!),
                                ),

                          //-----------------------Upload Image------------------
                          InkWell(
                            onTap: () => controller.imagePicker(),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(40.0),
                                  border: Border.all(
                                      color: Colors.white, width: 2.00)),
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 20.00,
                    ),

                    //----------------------Input Fields-------------------------
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          CustomField(
                            title: "Enter Your Full Name",
                            controller: fullName,
                          ),
                          const SizedBox(
                            height: 20.00,
                          ),
                          CustomField(
                            title: "Enter Your NID Name",
                            controller: nid,
                          ),
                          const SizedBox(
                            height: 20.00,
                          ),
                          CustomField(
                            title: "Enter Your Phone Number",
                            controller: phoneNumber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //-----------------------Button -------------------------
                CustomButton(
                  title: "Save Details",
                  ontap: () async {
                    await FirebaseFirestore.instance
                        .collection("user")
                        .doc(emailAddress)
                        .set({
                      "Email": emailAddress,
                      "Full Name": fullName.text,
                      "Nid": nid.text,
                      "Phone": phoneNumber.text,
                      "Balance": 0,
                      "Profile Pic": controller.imageDownloadLnk.value,
                    }).then((value) => Get.to(() => NavView()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
