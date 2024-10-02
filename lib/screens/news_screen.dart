import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news/classes/article_class.dart';
import 'package:news/model/article_Model.dart';
import 'package:news/provider/user_data.dart';
import 'package:news/screens/article_screen.dart';
import 'package:news/screens/profile_screen.dart';
import 'package:news/screens/search_screen.dart';
import 'package:news/shared/appColor.dart';
import 'package:news/shared/appPadding.dart';
import 'package:news/shared/appSized.dart';
import 'package:news/shared/appString.dart';
import 'package:news/widget/buildNews.dart';
import 'package:provider/provider.dart';
import '../shared/appStyle.dart';
import 'auth/login.dart';
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}
class _NewsScreenState extends State<NewsScreen> {
  bool loading = true;
  List<ArticleModel> news = [];
  @override
  void initState() {
    super.initState();
    getNews();
  }
  getNews()async{
    Article myNews = Article();
    await myNews.getArticle();
    news = myNews.news;
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.whiteColor,
      body:loading == true?
      Center(
        child:CircularProgressIndicator(color:AppColor.appColor,),
      ):
      Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: ListView(
          children:[
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment:CrossAxisAlignment.baseline,
                  textBaseline:TextBaseline.alphabetic,
                  children:[
                    Row(
                      children:[
                        Text(
                          AppString.welcome,
                          style:AppStyle.welcomeStyle
                        ),
                        SizedBox(
                          width:AppSized.sized1,
                        ),
                        FaIcon(
                          Icons.waving_hand,
                         color:AppColor.iconColor,
                        ),
                      ],
                    ),
                    Text(
                      "${context.read<UserData>().username}",
                      style:AppStyle.nameStyle
                    ),
                  ],
                ),
                PopupMenuButton(
                  color:AppColor.whiteColor,
                  onSelected:(val){
                    if(val == 0){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return ProfileScreen();
                      }));
                    }
                    if(val == 1){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return SearchScreen();
                      }));
                    }
                    if(val == 2){
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
                  },
                  iconSize:30,
                  itemBuilder:(context){
                    return [
                      PopupMenuItem(
                        value:0,
                        child:Row(
                          children:[
                            Icon(
                              Icons.person,
                            ),
                            SizedBox(
                              width:AppSized.sized1,
                            ),
                            Text(
                                AppString.popTxt1,
                                style:AppStyle.popStyle
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value:1,
                        child:Row(
                          children:[
                            Icon(
                              Icons.search,
                            ),
                            SizedBox(
                              width:AppSized.sized1,
                            ),
                            Text(
                              AppString.popTxt2,
                              style:AppStyle.popStyle
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value:2,
                        child:Row(
                          children:[
                            Icon(
                              Icons.logout,
                            ),
                            SizedBox(
                              width:AppSized.sized1,
                            ),
                            Text(
                              AppString.popTxt3,
                              style:AppStyle.popStyle
                            ),
                          ],
                        ),
                      ),
                    ];
                  }
                )
              ],
            ),
            SizedBox(
              height:AppSized.size3,
            ),
            Text(
              AppString.newText,
              style:AppStyle.newStyle
            ),
            SizedBox(
              height:AppSized.size5,
            ),
            ListView.builder(
              shrinkWrap:true,
              physics:NeverScrollableScrollPhysics(),
              itemCount:news.length,
              itemBuilder:(context,i){
                return InkWell(
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context){
                      return ArticleScreen(url:news[i].url,);
                    }));
                  },
                  child: BuildNews(
                      image:"${news[i].imageUrl}",
                      text1:"${news[i].title}",
                      text2:"${news[i].description}"
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
