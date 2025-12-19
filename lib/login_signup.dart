import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:v4c/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

SharedPreferences? sharedPreferences;
bool _passwordvisible = true;
var userName;

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  validateForm() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Log_in();
    } else {
      Fluttertoast.showToast(msg: "Please provide email and password");
    }
  }

  Log_in() async {
    showDialog(
        context: context,
        builder: (context) {
          return Loadingwidget(
            message: "Logging you in",
          );
        });
    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: \n $errorMessage");
    });
    if (currentUser != null) {
      checkuserexist(currentUser!);
    }
  }

  checkuserexist(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", currentUser.email!);
        await sharedPreferences!.setString("name", record.data()!["name"]);
        Navigator.push(context, MaterialPageRoute(builder: (c) => Homepage()));
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record do not exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_img_login.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/logo.png"),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: Icon(
                      Icons.mail_outline_outlined,
                      color: Color.fromARGB(127, 75, 97, 79),
                      size: 25.0 * textScaleFactor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  obscureText: _passwordvisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordvisible
                            ? Icons.lock
                            : Icons.no_encryption_outlined,
                        color: Color.fromARGB(127, 75, 97, 79),
                        size: 25.0 * textScaleFactor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordvisible = !_passwordvisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  validateForm();
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    Text(
                      "  Sign Up",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 6, 133, 237)),
                    )
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.01,
            )
          ],
        ),
      ),
    );
  }
}

class LoginNGO extends StatefulWidget {
  const LoginNGO({super.key});

  @override
  State<LoginNGO> createState() => _LoginNGOState();
}

class _LoginNGOState extends State<LoginNGO> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  validateForm() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Log_in();
    } else {
      Fluttertoast.showToast(msg: "Please provide email and password");
    }
  }

  Log_in() async {
    showDialog(
        context: context,
        builder: (context) {
          return Loadingwidget(
            message: "Logging you in",
          );
        });
    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: \n $errorMessage");
    });
    if (currentUser != null) {
      checkuserexist(currentUser!);
    }
  }

  checkuserexist(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("NGO")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", currentUser.email!);
        await sharedPreferences!.setString("name", record.data()!["name"]);
        Navigator.push(context, MaterialPageRoute(builder: (c) => Homepage()));
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record do not exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_img_login.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/logo.png"),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: Icon(
                      Icons.mail_outline_outlined,
                      color: Color.fromARGB(127, 75, 97, 79),
                      size: 25.0 * textScaleFactor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  obscureText: _passwordvisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordvisible
                            ? Icons.lock
                            : Icons.no_encryption_outlined,
                        color: Color.fromARGB(127, 75, 97, 79),
                        size: 25.0 * textScaleFactor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordvisible = !_passwordvisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  validateForm();
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    Text(
                      "  Sign Up",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 6, 133, 237)),
                    )
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.01,
            )
          ],
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  formValidation() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (c) {
            return Loadingwidget(
              message: "Registering your account",
            );
          });
      saveinfotodatabase();
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "This Feild is empty");
    }
  }

  saveinfotodatabase() async {
    // Authenticate the user
    User? currentUser =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ))
            .user;
    if (currentUser != null) {
      await saveinfotofirestoreandlocally(currentUser);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Failed to create user.");
    }
  }

  saveinfotofirestoreandlocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": _nameController.text.trim(),
      "type": 'user',
      "profile": ""
    });

    // Stored locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", _nameController.text.trim());
    await sharedPreferences!.setString("profile", "");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Homepage()));
    print("User data saved to Firestore successfully.");
    print("User UID: ${currentUser.uid}");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_img_login.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(height: screenHeight * 0.02),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: Icon(
                      Icons.person,
                      color: Color.fromARGB(127, 75, 97, 79),
                      size: 25.0 * textScaleFactor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.016,
            ),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: Icon(
                      Icons.mail_outline_outlined,
                      color: const Color.fromARGB(127, 75, 97, 79),
                      size: 25.0 * textScaleFactor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.016,
            ),
            SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: TextField(
                  obscureText: _passwordvisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(175, 0, 0, 0),
                      fontSize: 19.0 * textScaleFactor,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                    counterText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordvisible
                            ? Icons.lock
                            : Icons.no_encryption_outlined,
                        color: const Color.fromARGB(127, 75, 97, 79),
                        size: 25.0 * textScaleFactor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordvisible = !_passwordvisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(127, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(243, 75, 97, 79), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.016,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 135, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  formValidation();
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?  ",
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    Text(
                      " Log In",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 6, 133, 237)),
                    )
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.01,
            )
          ],
        ),
      ),
    );
  }
}

class Loadingwidget extends StatelessWidget {
  final String? message;
  Loadingwidget({
    this.message,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          Text(message.toString() + ",  Please wait...")
        ],
      ),
    );
  }
}
