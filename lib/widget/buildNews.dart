import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/shared/appStyle.dart';
// ignore: must_be_immutable
class BuildNews extends StatefulWidget {
  String image;
  String text1;
  String text2;
   BuildNews({
    super.key,
    required this.image,
    required this.text1,
    required this.text2
  });
  @override
  State<BuildNews> createState() => _BuildNewsState();
}
class _BuildNewsState extends State<BuildNews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15),
      child: Column(
        children:[
          Container(
            child: CachedNetworkImage(
              imageUrl:widget.image,
            ),
            clipBehavior:Clip.antiAlias,
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(15)
            ),
          ),
          Text(
            widget.text1,
            style:AppStyle.titleStyle
          ),
          Text(
            widget.text2,
            style:AppStyle.desStyle
          ),
        ],
      ),
    );
  }
}
