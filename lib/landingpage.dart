import 'package:flutter/material.dart';
import 'package:lexigo/login.dart';
import 'package:flutter/foundation.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Image.asset(
              'assets/Landingpage.png',
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight,
            ),
            Column(
              children: [
                // AppBar
                AppBar(
                  title: Row(
                    children: [

                      if (!kIsWeb)
                      Image.asset(
                        'assets/star-logo.gif',
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Lexigo',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Color(0xFFEAAD49),
                  elevation: 0,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Image
                        Image.asset(
                          'assets/Anim_Landingpage.png',
                          height: 300,
                        ),
                        SizedBox(height: 20),
                        // Dynamic Text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                          child: Text(
                            'Easy and Economic Way to Sharpen Your English Skills!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Start Study Button
                        Stack(
                          children: [
                            // Solid shadow
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF58A700),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child:
                                // Material with Ink
                                Material(
                                  elevation: 8.0, // Shadow for additional depth
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color:
                                      Color(0xFF58CC02), // Background color
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            LoginPage()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 7.0,
                                          bottom: 7.0,
                                          left: 12.0,
                                          right: 12.0),
                                        child: Text(
                                          'START STUDY!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
