import 'dart:async';
import 'package:flutter/material.dart';
import 'package:v4c/getstarted.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v4c/homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
if(FirebaseAuth.instance.currentUser != null) {
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    }else{
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => const GetStarted()));
    }
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_img_login.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
