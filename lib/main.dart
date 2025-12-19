import 'package:flutter/material.dart';
import 'package:v4c/login_signup.dart';
import 'package:v4c/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future <void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  
  FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V4C',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
