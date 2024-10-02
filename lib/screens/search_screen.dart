import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:news/helper/catgory_Data.dart';
import 'package:news/model/catgory_Model.dart';
import 'package:news/screens/catgoory_screen.dart';
import 'package:news/shared/appColor.dart';
import 'package:news/shared/appPadding.dart';
import 'package:news/shared/appString.dart';
import 'package:news/shared/appStyle.dart';
import 'package:news/widget/buildCatgory.dart';
import 'news_screen.dart';
// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
   SearchScreen({super.key, this.catgoryName});
   String? catgoryName;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  List<CatgoryModel> catgory = [];
  @override
  void initState() {
    super.initState();
    catgory = getCatgory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.whiteColor,
      appBar:AppBar(
        centerTitle:true,
        backgroundColor:AppColor.whiteColor,
        title:Text(
          AppString.grand,
          style:AppStyle.searchStyle
        ),
        leading: IconButton(
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
      ),
      body:Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: ListView(
          children:[
            ListView.builder(
              physics:NeverScrollableScrollPhysics(),
              shrinkWrap:true,
              itemCount:catgory.length,
              itemBuilder:(context , i){
                return InkWell(
                  onTap:(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                      return CatgoryScreen(catgoryName:catgory[i].title,);
                    }));
                  },
                  child: BuildCatgory(
                      image:"${catgory[i].imageUrl}",
                      text:"${catgory[i].title}"
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
