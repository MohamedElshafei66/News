import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/imageManger.dart';
import '../../shared/appColor.dart';
import '../../shared/appPadding.dart';
import '../../shared/appSized.dart';
import '../../shared/appString.dart';
import '../../shared/appStyle.dart';
import '../../widget/buildButton.dart';
import '../../widget/buildTextForm.dart';
import 'login.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.colorScaffold,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal:AppPadding.padding5),
            child:Form(
              key:formState,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                      height:AppSized.size2
                  ),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                            ImageManger.logo,
                            height: 80
                        ),
                        const Text(
                          AppString.logoText,
                          style:AppStyle.logoTextStyle
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  BuildTextForm(
                      validator:(text){
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!);
                        if(text == null || text.isEmpty){
                          return "this field shouldn't be empty";
                        }
                        else if(emailValid == false){
                          return "please enter correct email";
                        }
                        return null;
                      },
                      prefixIcon:Icons.email,
                      controller:email,
                      label:"Email"
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  Center(
                    child:BuildButton(
                        text:"Reset",
                      onPressed:()async{
                        if(email.text == ""){
                          Fluttertoast.showToast(
                              msg: "Firstly,you must enter your email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.buttonColor2,
                              textColor:AppColor.whiteColor,
                              fontSize: 16.0
                          );
                          return;
                        }
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email:email.text
                          );
                          Fluttertoast.showToast(
                              msg: "check your email to change password",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.buttonColor2,
                              textColor:AppColor.whiteColor,
                              fontSize: 16.0
                          );
                        }catch(e){
                          Fluttertoast.showToast(
                              msg: "enter your correct email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.buttonColor2,
                              textColor:AppColor.whiteColor,
                              fontSize: 16.0
                          );
                        }
                      },
                    )
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:[
                      const Text(
                        AppString.remember,
                        style:AppStyle.rememberStyle
                      ),
                      const SizedBox(
                        width:AppSized.sized1,
                      ),
                      InkWell(
                        hoverColor:AppColor.buttonColor2,
                        onTap:(){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                            return const Login();
                          }));
                        },
                        child: const Text(
                          AppString.loginText,
                          style:AppStyle.loginStyle
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }
}
