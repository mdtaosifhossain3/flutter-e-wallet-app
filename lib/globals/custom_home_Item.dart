import 'package:ewallet/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomHomeItem extends StatelessWidget {
  final dynamic icon;
  final String title;
  final void Function()? ontap;
  final Color? bgColor;
  final Color? itemColor;
  const CustomHomeItem(
      {Key? key,
      required this.icon,
      required this.title,
      this.ontap,
      this.bgColor,
      this.itemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 130,
        width: size.width * .3,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor ?? Appcolor.primary,
            borderRadius: BorderRadius.circular(20.00),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 0.8)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: itemColor ?? Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: itemColor ?? Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
