import 'package:flutter/material.dart';
import '../shared/appColor.dart';
import '../shared/appPadding.dart';
import '../shared/appStyle.dart';
// ignore: must_be_immutable
class BuildButton extends StatefulWidget {
  String text;
  void Function()? onPressed;
   BuildButton({super.key,required this.text,required this.onPressed});
  @override
  State<BuildButton> createState() => _BuildButtonState();
}
class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:widget.onPressed,
      splashColor:AppColor.buttonColor2,
      highlightColor:AppColor.buttonColor2,
      shape:OutlineInputBorder(
          borderRadius:BorderRadius.circular(15),
          borderSide:BorderSide.none
      ),
      color:AppColor.buttonColor2,
      child: Padding(
        padding: const EdgeInsets.only(right:AppPadding.padding6,left:AppPadding.padding6,top:AppPadding.padding4,bottom:AppPadding.padding4),
        child: Text(
          widget.text,
          style:AppStyle.buttonStyle
        ),
      ),
    );
  }
}
