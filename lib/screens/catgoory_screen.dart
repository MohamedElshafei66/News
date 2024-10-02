import 'package:flutter/material.dart';
import 'package:news/classes/catgory_class.dart';
import 'package:news/screens/search_screen.dart';
import 'package:news/shared/appColor.dart';
import 'package:news/shared/appString.dart';
import '../model/article_Model.dart';
import '../shared/appPadding.dart';
import '../shared/appStyle.dart';
import '../widget/buildNews.dart';
import 'article_screen.dart';
// ignore: must_be_immutable
class CatgoryScreen extends StatefulWidget {
   CatgoryScreen({super.key , this.catgoryName});
  String? catgoryName;
  @override
  State<CatgoryScreen> createState() => _CatgoryScreenState();
}
class _CatgoryScreenState extends State<CatgoryScreen> {
  bool loading = true;
  List<ArticleModel> news = [];
  @override
  void initState() {
    super.initState();
    getNews();
  }
  getNews()async{
    Catgory myNews = Catgory();
    await myNews.getArticle("${widget.catgoryName}");
    news = myNews.news;
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.whiteColor,
      appBar:AppBar(
        backgroundColor:AppColor.whiteColor,
        centerTitle:true,
        title:Text(
           "${widget.catgoryName} ${AppString.news}",
            style:AppStyle.searchStyle
        ),
        leading:IconButton(
          onPressed:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
              return SearchScreen();
            }));
          },
          icon:Icon(
            Icons.arrow_back,
            size:30,
          ),
        ),
      ),
      body:loading == true?
      Center(
        child:CircularProgressIndicator(color:AppColor.appColor,),
      ):
      Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: ListView(
          children:[
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
