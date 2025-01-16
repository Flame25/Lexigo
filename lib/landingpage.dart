import 'package:flutter/material.dart';
import 'package:lexigo/login.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("HAI"); 
        Navigator.pop(context, true);
        return false;
      },
      child: Material(
        child: Scaffold(
          body: Stack(
            children: [
              // Background image using Image.asset
              Image.asset(
                'assets/Landingpage.png', // Path to the background PNG
                fit: BoxFit.cover, // Cover the entire screen
                width: MediaQuery.of(context).size.width, // Full screen width
                height: MediaQuery.of(context).size.height, // Full screen height
              ),
              Column(
                children: [
                  AppBar(
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/star-logo.gif', // Path to your logo
                          height: 30, // Set height
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
                    backgroundColor: Color(0xFFEAAD49), // Make AppBar transparent
                    elevation: 0, // Remove shadow
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                        children: [
                          Positioned(
                            top: -100.0, // Adjust Y-axis position
                            left: MediaQuery.of(context).size.width / 2 -
                            150, // Center horizontally
                            child: Image.asset(
                              'assets/Anim_Landingpage.png', // Path to PNG image
                              height: 300, // Adjust size as needed
                            ),
                          ),
                          SizedBox(height: 20), // Space between image and text
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width *
                              0.07, // 10% of screen width
                            ),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                BoxConstraints constraints) {
                                double fontSize = constraints.maxWidth *
                                0.1; // Scale font size based on screen width
                                return Text(
                                  'Easy and Economic Way to Sharpen Your English Skills!',
                                  textAlign:
                                  TextAlign.center, // Center-align text
                                  style: TextStyle(
                                    fontSize: fontSize, // Dynamic font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.5, // Line height for spacing
                                  ),
                                );
                              },
                            ),
                          ),

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
      ),
    );
  }
}
