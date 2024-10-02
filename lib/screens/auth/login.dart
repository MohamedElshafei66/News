import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news/screens/auth/signup.dart';
import 'package:news/screens/news_screen.dart';
import 'package:provider/provider.dart';
import '../../core/utils/imageManger.dart';
import '../../provider/user_data.dart';
import '../../shared/appColor.dart';
import '../../shared/appPadding.dart';
import '../../shared/appSized.dart';
import '../../shared/appString.dart';
import '../../shared/appStyle.dart';
import '../../widget/buildButton.dart';
import '../../widget/buildTextForm.dart';
import 'forgetpassword.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final String userName = googleUser.displayName ?? '';
      final String email = googleUser.email;
      setState(() {
        loading = true;
      });
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Provider.of<UserData>(context,listen:false).setMyData(userName,email);
      Fluttertoast.showToast(
        msg: "Success Login",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.buttonColor2,
        textColor: AppColor.whiteColor,
        fontSize: 16.0,
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const NewsScreen();
      }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.buttonColor2,
          textColor: AppColor.whiteColor,
          fontSize: 16.0);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  bool loading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:AppPadding.padding5),
        child:Form(
          key:formState,
          child:loading == true?
         const Center(
           child:CircularProgressIndicator(color:AppColor.buttonColor2,),
         )
          :ListView(
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
              Center(
                child: TextButton(
                    onPressed:(){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return const ForgetPassword();
                      }));
                    },
                    child:const Text(
                        AppString.forgetPass,
                        style:AppStyle.forgetStyle
                    )
                ),
              ),
              const SizedBox(
                  height:AppSized.size3
              ),
              Center(
                  child:BuildButton(
                    text:"Login",
                    onPressed:()async{
                      if(formState.currentState!.validate()){
                        loading = true;
                        setState((){});
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email:email.text,
                            password:password.text
                        ).then((value){
                          if(FirebaseAuth.instance.currentUser!.emailVerified){
                            Provider.of<UserData>(context,listen:false)
                                .setMyData(userName.text,email.text);
                            Fluttertoast.showToast(
                                msg: "Success Login",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:AppColor.buttonColor2,
                                textColor:AppColor.whiteColor,
                                fontSize: 16.0
                            );
                            Future.delayed(
                                const Duration(seconds:2),
                                    (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                                    return const NewsScreen();
                                  }));
                                }
                            );
                          }
                          else{
                            loading = false;
                            setState((){});
                            Fluttertoast.showToast(
                                msg: "check your email to verify it.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:AppColor.buttonColor2,
                                textColor:AppColor.whiteColor,
                                fontSize: 16.0
                            );
                          }
                        }).catchError((e){
                          loading = false;
                          setState((){});
                          Fluttertoast.showToast(
                              msg: "Your email or password is wrong!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.buttonColor2,
                              textColor:AppColor.whiteColor,
                              fontSize: 16.0
                          );
                        });
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
                    padding: EdgeInsets.symmetric(horizontal:AppPadding.padding7),
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
              MaterialButton(
                  onPressed:()async{
                    await signInWithGoogle();
                  },
                  splashColor:AppColor.googleButton,
                  highlightColor:AppColor.googleButton,
                  shape:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(15),
                      borderSide:BorderSide.none
                  ),
                  color:AppColor.googleButton,
                  child:const Padding(
                    padding: EdgeInsets.only(right:AppPadding.padding4,left:AppPadding.padding4,top:AppPadding.padding4,bottom:AppPadding.padding4),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children:[
                        Padding(
                          padding: EdgeInsets.only(right:15),
                          child: ClipRRect(
                              child:Image(
                                image:AssetImage(
                                  ImageManger.googleIcon,
                                ),
                                height:50,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right:AppPadding.padding8),
                          child: Text(
                              AppString.googleText,
                              style:AppStyle.text2

                          ),
                        ),
                      ],
                    ),
                  )
              ),
              const SizedBox(
                  height:AppSized.size3
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  const Text(
                      AppString.dontHave,
                      style:AppStyle.rememberStyle
                  ),
                  const SizedBox(
                      width:AppSized.size4
                  ),
                  InkWell(
                    hoverColor:AppColor.buttonColor2,
                    onTap:(){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return const SignUp();
                      }));
                    },
                    child: const Text(
                        AppString.register,
                        style:AppStyle.loginStyle
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:AppSized.size2
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
        ),
      )
    );

  }
}
