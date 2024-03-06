import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title;
  final bool secure;
  final IconData? prefixIcon;
  final TextInputType? keybard;
  final TextEditingController? controller;

  const CustomField(
      {Key? key,
      required this.title,
      this.secure = false,
      this.prefixIcon,
      this.keybard,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keybard,
      obscureText: secure,
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: title,
          //Border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.4))),
          //Focus Border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 2.00)),
          //Error Border
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red, width: 2.00))),
    );
  }
}
