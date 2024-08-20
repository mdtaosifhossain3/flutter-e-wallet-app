import 'package:ewallet/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final icon;
  final Color? itemColor;
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
        ),
        tileColor: Colors.white,
        onTap: ontap,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: icon ??
            CircleAvatar(
              child: Text(title.isNotEmpty ? title[0] : ""),
            ),
        title: Text(
          title.isNotEmpty ? title : "No Name",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(color: Colors.black.withOpacity(.5)),
        ),
        trailing: Text(
          price,
          style: TextStyle(color: itemColor ?? Appcolor.primary, fontSize: 18),
        ),
      ),
    );
  }
}
