import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/news_screen.dart';
import 'package:provider/provider.dart';
import '../../core/utils/imageManger.dart';
import '../../provider/user_data.dart';
import '../../shared/appPadding.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool _animate = false;
  @override
  void initState() {
    super.initState();
    // Start the animation after a delay and navigate to the next screen
    Future.delayed(const Duration(microseconds:250), () {
      setState(() {
        _animate = true;
      });
      _navigateToNextScreen(); // Call to navigate after animation starts
    });
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for a bit before navigation
    final userData = Provider.of<UserData>(context, listen: false);
    await userData.loadUserData();
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    } else if (user.emailVerified) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NewsScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: AppPadding.padding1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationAnimatedWidget.tween(
              enabled: _animate,
              duration: const Duration(seconds:1),
              child: Image.asset(
                ImageManger.logo,
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

