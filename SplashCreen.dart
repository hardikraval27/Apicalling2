import 'package:apicalling/Homepage.dart';
import 'package:apicalling/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCreen extends StatefulWidget {
  static SharedPreferences? prefrs;
  const SplashCreen({Key? key}) : super(key: key);
  @override
  State<SplashCreen> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashCreen> {
  bool Islogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForloginSttaus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Lottie.asset("animation/loading.json"),));
  }

  Future<void> ForloginSttaus() async {
    SplashCreen.prefrs = await SharedPreferences.getInstance();
    setState(() {
      Islogin = SplashCreen.prefrs!.getBool("loginstatus") ?? false;
    });
  Future.delayed(Duration(seconds: 5)).then((value){

    if (Islogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    } else {

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Loginpage();
        },
      ));
    }
  });
  }
}
