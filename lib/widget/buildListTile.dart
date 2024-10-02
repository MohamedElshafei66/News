import 'package:flutter/material.dart';
// ignore: must_be_immutable
class BuildListTile extends StatelessWidget {
  IconData icon;
  String text;
  void Function()? onTap;
   BuildListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size:35,
      ),
      title: Text(
        text,
        style:TextStyle(
            fontSize:22
        ),
      ),
      onTap:onTap,
    );
  }
}
