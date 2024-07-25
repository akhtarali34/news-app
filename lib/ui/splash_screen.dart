import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_api/ui/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height* 1;


    return Scaffold(
      body: Column(
mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/splash_pic.jpg", fit: BoxFit.cover
            ,height: height*.5,),
          SizedBox(height: 20,),
          Text("TOP HEADLINES", style:TextStyle(fontWeight: FontWeight.bold),),

          SpinKitChasingDots( color: Colors.amberAccent,),
        ],
      ),
    );
  }
}
