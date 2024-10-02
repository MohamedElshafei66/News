import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news/provider/user_data.dart';
import 'package:news/screens/auth/login.dart';
import 'package:news/screens/news_screen.dart';
import 'package:news/shared/appColor.dart';
import 'package:news/shared/appSized.dart';
import 'package:news/shared/appString.dart';
import 'package:news/shared/appStyle.dart';
import 'package:news/widget/buildListTile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor:AppColor.whiteColor,
        title: Text(
            AppString.profScreen,
          style:AppStyle.profileScreenStyle
        ),
        leading:IconButton(
          onPressed:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
              return NewsScreen();
            }));
          },
          icon:Icon(
            Icons.arrow_back,
            size:30,
          ),
        ),
        centerTitle:true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSized.size5),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:AppColor.appColor,
                  radius: 40,
                  child:Icon(
                      Icons.person,
                      color:AppColor.whiteColor,
                      size:40,
                  ),
                ),
                SizedBox(
                    width:AppSized.size5
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.read<UserData>().username}',
                      style:AppStyle.userStyle
                    ),
                    SizedBox(
                        height:AppSized.size4
                    ),
                    Text(
                      '${context.read<UserData>().email}',
                      style:AppStyle.emailStyle
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
                height:AppSized.size3
            ),
            Divider(),
            BuildListTile(
                text:AppString.profile,
                icon:Icons.person,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.setting,
                icon:Icons.settings,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.notification,
                icon:Icons.notifications,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.lang,
                icon:Icons.language,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.faq,
                icon:Icons.chat_rounded,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.about,
                icon:Icons.priority_high,
                onTap:(){}
            ),
            SizedBox(
                height:AppSized.size5
            ),
            BuildListTile(
                text:AppString.logout,
                icon:Icons.logout,
                onTap:(){
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      animType: AnimType.bottomSlide,
                      desc: 'Want to exit from app?',
                      descTextStyle:TextStyle(
                        fontSize:22,
                        color:Colors.black
                      ),
                      btnCancelOnPress:(){},
                      btnOkOnPress:()async{
                        await FirebaseAuth.instance.signOut();
                        GoogleSignIn google = GoogleSignIn();
                        google.disconnect();
                        Provider.of<UserData>(context, listen: false).clearUserData();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder:(context) =>const Login()),
                        );
                      },
                      btnOkColor:Color(0xff83b0e1),
                      btnCancelColor:Color(0xff83b0e1),
                      buttonsTextStyle:TextStyle(
                        fontSize:18,
                        fontWeight:FontWeight.w600,
                        color:AppColor.whiteColor
                      )
                  )..show();
                }
            ),
          ],
        ),
      ),
    );
  }
}

