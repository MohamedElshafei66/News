import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_Model.dart';
class Catgory{
  List<ArticleModel> news = [];
  Future<void>getArticle(String catgory)async{
    String uri = "https://newsapi.org/v2/top-headlines?country=us&category=$catgory&apiKey=2c54e534ec134949822cad064eefb23b";
    var response = await http.get(Uri.parse(uri));
    var responseBody = await jsonDecode(response.body);
    if(responseBody['status'] == "ok"){
      responseBody['articles'].forEach((e){
        if(e['description'] != null && e['urlToImage'] != null){
          ArticleModel articleModel = ArticleModel(
              title:e['title'],
              description:e['description'],
              url:e['url'],
              imageUrl:e['urlToImage']
          );
          news.add(articleModel);
        }
      });
    }
  }

}