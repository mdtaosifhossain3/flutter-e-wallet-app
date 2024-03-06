import 'package:ewallet/controllers/nav_controller.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavView extends StatelessWidget {
  NavView({Key? key}) : super(key: key);

  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.currentValue.value],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Appcolor.primary,
              unselectedItemColor: Colors.black,
              currentIndex: controller.currentValue.value,
              onTap: (index) => controller.changeValue(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), label: "Contacts"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.wallet), label: "Wallet"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings")
              ]),
        ));
  }
}
