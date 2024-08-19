import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppbar(
    {String? title,
    bool? arrorw = false,
    List<Widget>? action,
    required context}) {
  return AppBar(
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          : null,
      centerTitle: true,
      leading: arrorw == true
          ? IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back))
          : null,
      actions: action);
}
