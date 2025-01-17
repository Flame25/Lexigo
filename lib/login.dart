import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  Color _signupColor = Color(0xFF58CC02);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? userId = "1";

  Future<void> saveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    print(_usernameController.text);
    print(_passwordController.text);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Success') {
        // Navigate to the next page or show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Successful'),
        ));

        await saveSession(data['user_id']);

        Navigator.pushNamed(
          context,
          '/home',
        ).then((result) {
          if (result == true) {
            loadSession();
          }
        });
      } else {
        print("AAAA");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'] ?? 'Login Failed'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server error, please try again later.'),
      ));
    }
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString("user_id");
    });

    if (userId != null) {
      Navigator.pushNamed(context, '/home').then((result) {
        if (result == true) {
          loadSession();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          setState(() {}); // Refresh page
        }
      },
      child: Material(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Image.asset(
                'assets/Landingpage.png', // Path to the background PNG
                fit: BoxFit.cover, // Cover the entire screen
                width: MediaQuery.of(context).size.width, // Full screen width
                height:
                    MediaQuery.of(context).size.height, // Full screen height
              ),
              SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 40, bottom: 10, right: 20, left: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFF003566),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Color(0xFFFFDE00),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                      color: Color(0xFFFFF8C6),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextField(
                                    controller: _usernameController,
                                    style: TextStyle(
                                        color: Color(0xFFFFF8C6), fontSize: 16),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: Colors
                                              .grey, // Border color when not focused
                                          width: 1.0, // Border thickness
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: Colors
                                              .blue, // Border color when focused
                                          width:
                                              2.0, // Border thickness when focused
                                        ),
                                      ),
                                      hintText: "Username here",
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                      color: Color(0xFFFFF8C6),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Color(0xFFFFF8C6), fontSize: 16),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey, // Border color when not focused
                                            width: 1.0, // Border thickness
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .blue, // Border color when focused
                                            width:
                                                2.0, // Border thickness when focused
                                          ),
                                        ),
                                        hintText: "Password here"),
                                  ),
                                  _isLoading
                                      ? Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                // Make this container take up the full width
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF58A700),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Material(
                                                    elevation:
                                                        8.0, // Shadow for additional depth
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: Ink(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFF58CC02), // Background color
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        onTap: _login,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 7.0,
                                                            bottom: 7.0,
                                                            left: 12.0,
                                                            right: 12.0,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'LOGIN',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18.0,
                                                              ),
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
                                        ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 24,
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    return Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: List.generate(
                                                        (constraints.constrainWidth() /
                                                                3)
                                                            .floor(),
                                                        (index) => SizedBox(
                                                          height: 3,
                                                          width: 3,
                                                          child: DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Center(
                                                child: Material(
                                                  color: Color(0xFF003566),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Text(
                                                      "Or",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          // Make this container take up the full width
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF4B4B4B),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Material(
                                              elevation:
                                                  8.0, // Shadow for additional depth
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .white, // Background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage(),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 7.0,
                                                      bottom: 7.0,
                                                      left: 12.0,
                                                      right: 12.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/google_logo.png', // Path to the background PNG
                                                          fit: BoxFit
                                                              .cover, // Cover the entire screen
                                                          width:
                                                              23, // Full screen width
                                                          height:
                                                              23, // Full screen height)
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Continue with Google',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF4B4B4B),
                                                            fontSize: 18.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "New here? ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            // Change the text color when clicked
                                            _signupColor = _signupColor ==
                                                    Color(0xFF58CC02)
                                                ? Color(0xFF003566)
                                                : Color(0xFF58CC02);
                                          });
                                          Navigator.pushNamed(
                                                  context, '/signup')
                                              .then((result) {
                                            if (result == true) {
                                              loadSession();
                                            }
                                          });
                                        },
                                        child: Text(
                                          "sign up",
                                          style: TextStyle(
                                            color: _signupColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: _signupColor,
                                            decorationThickness: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
