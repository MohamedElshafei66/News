import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/provider/user_data.dart';
import 'package:news/screens/auth/SplashScreen.dart';
import 'package:provider/provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData()..loadUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.ptSansCaptionTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    );

  }
}