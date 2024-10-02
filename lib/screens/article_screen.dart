import 'package:flutter/material.dart';
import 'package:news/shared/appColor.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/appString.dart';
import '../shared/appStyle.dart';
// ignore: must_be_immutable
class ArticleScreen extends StatefulWidget {
  final String? url;
  const ArticleScreen({super.key, this.url});
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}
class _ArticleScreenState extends State<ArticleScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if(mounted){
              setState(() {
                isLoading = false; // Page is loading
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:AppColor.whiteColor,
        appBar:AppBar(
          centerTitle:true,
          title:Text(
              "${AppString.article}",
              style:AppStyle.searchStyle
          ),
          backgroundColor:AppColor.whiteColor,
        ),
        body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          isLoading
              ? Center(
              child: CircularProgressIndicator(color:AppColor.appColor,),
          )
              : SizedBox.shrink(),
        ],
      ),

    );
  }
}
