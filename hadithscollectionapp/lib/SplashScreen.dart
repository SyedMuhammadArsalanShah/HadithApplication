import 'dart:async';

import 'package:flutter/material.dart';
import 'TabsScr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TabsScr()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0XFF262626),
            ),
            child:Image.asset("assets/hadith.jpg",width: double.infinity,height:double.infinity ,)
                      ),
        ),
        backgroundColor: Color(0XFFD9D9D9));
  }
}
