import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../core/utils/imageManger.dart';
import '../../shared/appColor.dart';
import '../../shared/appPadding.dart';
import '../../shared/appSized.dart';
import '../../shared/appString.dart';
import '../../shared/appStyle.dart';
import 'login.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageViewModel>? pages = [
    PageViewModel(
      title:"",
      bodyWidget: Column(
        textBaseline:TextBaseline.alphabetic,
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Center(child:
          Image.asset(ImageManger.onBoarding1,
            height:350,
          )),
           const SizedBox(
            height:AppSized.sized1
          ),
           const Text(
            AppString.onboardingTxt1,
            style:AppStyle.text1
          ),
           const SizedBox(
              height:AppSized.sized1
          ),
           const Padding(
            padding: EdgeInsets.only(left:AppPadding.padding2),
            child: Text(
              AppString.onboardingTxt2,
              style:AppStyle.text2
            ),
          )
        ],
      ),
    ),
    PageViewModel(
      title:"",
      bodyWidget: Column(
        textBaseline:TextBaseline.alphabetic,
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Center(child:
           Image.asset(ImageManger.onBoarding2,
             height:350,
           )),
          const SizedBox(
              height:AppSized.sized1,
          ),
          const Text(
            AppString.onboardingTxt3,
            style:AppStyle.text1
          ),
          const SizedBox(
              height:10
          ),
          const Padding(
            padding: EdgeInsets.only(left:AppPadding.padding2),
            child: Text(
                AppString.onboardingTxt4,
                style:AppStyle.text2
            ),
          )
        ],
      ),
    ),
    PageViewModel(
      title:"",
      bodyWidget: Column(
        textBaseline:TextBaseline.alphabetic,
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Center(child:
           Image.asset(ImageManger.onBoarding3,
             height:350,
           )
          ),
          const SizedBox(
              height:AppSized.sized1
          ),
          const Text(
             AppString.onboardingTxt5,
              style:AppStyle.text1
          ),
          const SizedBox(
              height:10
          ),
          const Padding(
            padding: EdgeInsets.only(left:AppPadding.padding2),
            child: Text(
              AppString.onboardingTxt6,
              style:AppStyle.text2
            ),
          )
        ],
      ),
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IntroductionScreen(
        pages:pages,
        showDoneButton:true,
        showNextButton:true,
        showSkipButton:true,
        done:Container(
          decoration: BoxDecoration(
            color:AppColor.buttonColor,
            borderRadius:BorderRadius.circular(10),
          ),
          child:const Padding(
            padding: EdgeInsets.only(right:AppPadding.padding3,left:AppPadding.padding3,top:AppPadding.padding4,bottom:AppPadding.padding4),
            child: Text(
             AppString.done,
              style:AppStyle.button
            ),
          ),
        ),
        next:Container(
          decoration: BoxDecoration(
            color:AppColor.buttonColor,
            borderRadius:BorderRadius.circular(10),
          ),
          child:const Padding(
            padding: EdgeInsets.only(right:AppPadding.padding3,left:AppPadding.padding3,top:AppPadding.padding4,bottom:AppPadding.padding4),
            child: Text(
              AppString.next,
              style:AppStyle.button
            ),
          ),
        ),
        skip:Container(
          decoration: BoxDecoration(
            color:AppColor.buttonColor,
            borderRadius:BorderRadius.circular(10),
          ),
          child:const Padding(
            padding: EdgeInsets.only(right:AppPadding.padding3,left:AppPadding.padding3,top:AppPadding.padding4,bottom:AppPadding.padding4),
            child: Text(
              AppString.skip,
              style:AppStyle.button
            ),
          ),
        ),
        onDone:(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
            return const Login();
          }));
        },
        curve:Curves.bounceInOut,
        dotsDecorator:const DotsDecorator(
            activeColor:AppColor.buttonColor

        ),
      ),
    );
  }
}
