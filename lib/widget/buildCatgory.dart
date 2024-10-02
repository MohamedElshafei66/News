import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/shared/appSized.dart';
import 'package:news/shared/appStyle.dart';
class BuildCatgory extends StatefulWidget {
  final String image;
  final String text;
  const BuildCatgory({super.key, required this.image, required this.text});
  @override
  State<BuildCatgory> createState() => _BuildCatgoryState();
}
class _BuildCatgoryState extends State<BuildCatgory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(AppSized.sized1),
      child:Stack(
        alignment:Alignment.center,
        children:[
          Container(
            child: CachedNetworkImage(
              imageUrl:"${widget.image}",
              width:420,
            ),
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(15)
            ),
            clipBehavior:Clip.antiAlias,
          ),
          Container(
            child:Padding(
              padding: const EdgeInsets.only(left:AppSized.size5,right:AppSized.size5,),
              child: Text(
                "${widget.text}",
                style:AppStyle.catgoryStyle,
              ),
            ),
            clipBehavior:Clip.antiAlias,
            decoration:BoxDecoration(
                color:Colors.black54,
                borderRadius:BorderRadius.circular(15)
            ),
          ),
        ],
      ),
    );
  }
}
