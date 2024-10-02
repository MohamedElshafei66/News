import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/imageManger.dart';
import '../../shared/appColor.dart';
import '../../shared/appSized.dart';
import '../../shared/appString.dart';
import '../../shared/appStyle.dart';
import '../../widget/buildButton.dart';
import '../../widget/buildTextForm.dart';
import 'login.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  bool isMediaReporter = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                        if(text == null || text.isEmpty){
                          return "this field shouldn't be empty";
                        }
                        return null;
                      },
                      prefixIcon:Icons.person,
                      controller:userName,
                      label:"Username"
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
                  BuildTextForm(
                    validator:(text){
                      if(text == null || text.isEmpty){
                        return "this field shouldn't be empty";
                      }
                      return null;
                    },
                    prefixIcon:Icons.lock,
                    controller:password,
                    label:"Password",
                    isPassword:true,
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor:AppColor.buttonColor,
                        value:true,
                        groupValue:isMediaReporter,
                        onChanged:(value){
                          setState(() {
                            isMediaReporter = value!;
                          });
                        },
                      ),
                      const Text(
                          AppString.selector1,
                          style:AppStyle.selector
                      ),
                      Radio(
                        activeColor:AppColor.buttonColor,
                        value:false,
                        groupValue: isMediaReporter,
                        onChanged: (value) {
                          setState(() {
                            isMediaReporter = value!;
                          });
                        },
                      ),
                      const Text(
                          AppString.selector2,
                          style:AppStyle.selector
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  Center(
                    child:BuildButton(
                        text:"Sign Up",
                      onPressed:()async{
                        if(formState.currentState!.validate()){
                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email:email.text,
                              password:password.text,
                            );
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                              return const Login();
                            }));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(
                                  msg: "The password is too weak",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:AppColor.buttonColor2,
                                  textColor:AppColor.whiteColor,
                                  fontSize: 16.0
                              );
                            } else if (e.code == 'email-already-in-use') {
                              Fluttertoast.showToast(
                                  msg: "The account already exists for that email.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:AppColor.buttonColor2,
                                  textColor:AppColor.whiteColor,
                                  fontSize: 16.0
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    )
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color:AppColor.greyColor
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            AppString.signInText,
                            style:AppStyle.signInStyle
                        ),
                      ),
                      Expanded(
                          child:Divider(
                              color:AppColor.greyColor
                          )),
                    ],
                  ),
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:[
                      const Text(
                        AppString.haveAcc,
                          style:AppStyle.rememberStyle
                      ),
                      const SizedBox(
                          width:AppSized.size4
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
                  const SizedBox(
                      height:AppSized.size3
                  ),
                  const Center(
                    child: Text(
                     AppString.terms,
                      textAlign: TextAlign.center,
                      style:AppStyle.terms
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
