import 'package:ewallet/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final String title;
  final subTitle;
  final price;
  final icon;
  final itemColor;
  final void Function()? ontap;
  const CustomList(
      {Key? key,
      this.icon,
      this.ontap,
      required this.price,
      required this.subTitle,
      required this.title,
      this.itemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.00),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.00),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: icon ??
                CircleAvatar(
                  child: Text(title[0]),
                ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(color: Colors.black.withOpacity(.5)),
            ),
            trailing: Text(
              price,
              style:
                  TextStyle(color: itemColor ?? Appcolor.primary, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
