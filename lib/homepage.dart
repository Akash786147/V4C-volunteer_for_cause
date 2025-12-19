import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v4c/splash.dart';
import 'package:v4c/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String username = "Loading...";
  int points = 100;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("name") ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello,  $username",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Color(0xff303030),
                fontSize: textScaleFactor * 18),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_active_sharp,
                  size: textScaleFactor * 32,
                  color: Color(0XFF303030),
                ))
          ],
        ),
        drawer: Drawer(
          // backgroundColor: Color.fromARGB(255, 197, 176, 202),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 197, 176, 202),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/homepagebg.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.04,
                ),

                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: screenWidth * 0.90,
                    height: screenHeight * 0.072,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    )),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                //communities column - heading and row consisting of columns
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),

                    // Container(
                    //   width: screenWidth,
                    //   height: screenHeight*0.03,
                    //   color: Colors.black,
                    // ),

                    Text(
                      "Communities",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff303030),
                        fontSize: textScaleFactor * 18,
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                                height: screenHeight * 0.24,
                                width: screenWidth * 0.36,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        249, 232, 213, 239),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/diyafoundation.png"),
                                        height: screenHeight * 0.16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Diya Foundation ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff303030),
                                                  fontSize:
                                                      textScaleFactor * 11),
                                            ),
                                            Text(
                                              "A happy inclusive environment for the especially abled.",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff00171F),
                                                  fontSize:
                                                      textScaleFactor * 8),
                                            )
                                          ],
                                        )),
                                  ],
                                )),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Container(
                                height: screenHeight * 0.24,
                                width: screenWidth * 0.36,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        249, 232, 213, 239),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: AssetImage("assets/chetna.png"),
                                        height: screenHeight * 0.16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Chetna ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff303030),
                                                  fontSize:
                                                      textScaleFactor * 11),
                                            ),
                                            Text(
                                              "An currently benefitting more than 300,000 underprivileged children.",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff00171F),
                                                  fontSize:
                                                      textScaleFactor * 8),
                                            )
                                          ],
                                        )),
                                  ],
                                )),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Container(
                                height: screenHeight * 0.24,
                                width: screenWidth * 0.36,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        249, 232, 213, 239),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image:
                                            AssetImage("assets/ashakiran.png"),
                                        height: screenHeight * 0.16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Asha-Kiran ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff303030),
                                                  fontSize:
                                                      textScaleFactor * 11),
                                            ),
                                            Text(
                                              "Be the ASHA to someone’s basic human rights",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff00171F),
                                                  fontSize:
                                                      textScaleFactor * 8),
                                            )
                                          ],
                                        )),
                                  ],
                                )),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Container(
                                height: screenHeight * 0.24,
                                width: screenWidth * 0.36,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        249, 232, 213, 239),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/diyafoundation.png"),
                                        height: screenHeight * 0.16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Diya Foundation ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff303030),
                                                  fontSize:
                                                      textScaleFactor * 11),
                                            ),
                                            Text(
                                              "A happy inclusive environment for the especially abled.",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff00171F),
                                                  fontSize:
                                                      textScaleFactor * 8),
                                            )
                                          ],
                                        )),
                                  ],
                                )),
                          ],
                        )),
                  ],
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              side: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(45, 45, 7, 4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(204, 234, 232, 232),
                              foregroundColor:
                                  const Color.fromARGB(219, 218, 22, 68)),
                          onPressed: () {},
                          child: Container(
                            width: screenWidth * 0.22,
                            height: screenHeight * 0.10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/icons/register.png"),
                                  height: screenHeight * 0.05,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        width: screenWidth * 0.016,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(45, 45, 7, 4),
                              ),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(204, 234, 232, 232),
                              foregroundColor:
                                  const Color.fromARGB(219, 218, 22, 68)),
                          onPressed: () {},
                          child: Container(
                            width: screenWidth * 0.21,
                            height: screenHeight * 0.10,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 232, 245, 233),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/icons/events.png"),
                                  height: screenHeight * 0.05,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Events",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        width: screenWidth * 0.016,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(45, 45, 7, 4),
                              ),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(204, 234, 232, 232),
                              foregroundColor:
                                  const Color.fromARGB(219, 218, 22, 68)),
                          onPressed: () {},
                          child: Container(
                            width: screenWidth * 0.21,
                            height: screenHeight * 0.10,
                            decoration: BoxDecoration(
                                // color: const Color.fromARGB(242, 10, 242, 29),
                                borderRadius: BorderRadius.circular(8)),
                            // padding: EdgeInsets.all(0),
                            // margin: EdgeInsets.all(0),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/icons/rewards.png"),
                                  height: screenHeight * 0.05,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Rewards",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        width: screenWidth * 0.016,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(45, 45, 7, 4),
                              ),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(204, 234, 232, 232),
                              foregroundColor:
                                  const Color.fromARGB(219, 218, 22, 68)),
                          onPressed: () {},
                          child: Container(
                            width: screenWidth * 0.21,
                            height: screenHeight * 0.10,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 232, 245, 233),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/icons/explore.png"),
                                  height: screenHeight * 0.05,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Explore",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
