import 'package:flutter/material.dart';
import '../shared/appColor.dart';
import '../shared/appStyle.dart';
// ignore: must_be_immutable
class BuildTextForm extends StatefulWidget {
  String?  Function(String?)? validator;
  String label;
  IconData prefixIcon;
  TextEditingController controller;
  IconData? suffixIcon;
  final bool isPassword;
   BuildTextForm({
     super.key,
    required  this.validator,
    required this.prefixIcon,
    required this.controller,
    required this.label,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  State<BuildTextForm> createState() => _BuildTextFormState();
}

class _BuildTextFormState extends State<BuildTextForm> {
  bool _obscureText = true;
  void hideMyPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor:AppColor.buttonColor2,
      style:AppStyle.textFormContent,
      obscureText: widget.isPassword ? _obscureText : false,
      controller:widget.controller,
      validator:widget.validator,
      decoration:InputDecoration(
          labelText:widget.label,
          labelStyle:AppStyle.buildWidget,
          prefixIcon:Icon(
            widget.prefixIcon,
          ),
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed:hideMyPass,
          ) : null,
          focusedBorder:const OutlineInputBorder(
              borderSide:BorderSide(
                  color:AppColor.buttonColor
              )
          )
      ),
    );
  }
}
