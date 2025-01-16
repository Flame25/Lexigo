import 'package:flutter/material.dart';
import 'dart:convert';
import 'login.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  Color _loginColor = Color(0xFF58CC02);
  final _usernameText = TextEditingController();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final _confirmPassText = TextEditingController();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    bool isValidEmail(String email) {
      // Regular expression for email validation
      final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      // Test the email against the regular expression
      return emailRegExp.hasMatch(email);
    }


    Future<void> _signUp() async {
      setState(() {
        _isLoading = true;
      });

      if (_confirmPassText.text != _passwordText.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password and confirm password not match'),
          ),
        );
      }

      if(!isValidEmail(_emailText.text)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Input a valid email'),
          ),
        );
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameText.text,
          'password': _passwordText.text,
          'email': _emailText.text
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Success') {
          // Navigate to the next page or show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Register Successful'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data['message'] ?? 'Register Failed'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server error, please try again later.'),
          ),
        );
      }
    }

    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Image.asset(
              'assets/Landingpage.png', // Path to the background PNG
              fit: BoxFit.cover, // Cover the entire screen
              width: MediaQuery.of(context).size.width, // Full screen width
              height: MediaQuery.of(context).size.height, // Full screen height
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
                          borderRadius: BorderRadius.all(Radius.circular(40))),
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
                                  "SIGN UP",
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
                                  controller: _usernameText,
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
                                  "Email",
                                  style: TextStyle(
                                    color: Color(0xFFFFF8C6),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _emailText,
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
                                    hintText: "Email here",
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
                                  controller: _passwordText,
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
                                const SizedBox(height: 20),
                                const Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                    color: Color(0xFFFFF8C6),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  controller: _confirmPassText,
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
                                    hintText: "Confirm Password here"),
                                ),
                                _isLoading
                                ? Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ): 
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // Make this container take up the full width
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF58A700),
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
                                                color: Color(
                                                  0xFF58CC02), // Background color
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0),
                                                onTap: _signUp,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                    top: 7.0,
                                                    bottom: 7.0,
                                                    left: 12.0,
                                                    right: 12.0,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'SIGN UP',
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
                                                          decoration: BoxDecoration(
                                                            color: Colors
                                                            .grey
                                                            .shade300))),
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
                                                onTap: _signUp,
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
                                      "Already have an account? ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                            // Change the text color when clicked
                                            _loginColor =
                                            _loginColor == Color(0xFF58CC02)
                                            ? Color(0xFF003566)
                                            : Color(0xFF58CC02);
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            LoginPage()));
                                      },
                                      child: Text(
                                        "log in",
                                        style: TextStyle(
                                          color: _loginColor,
                                          decoration:
                                          TextDecoration.underline,
                                          decorationColor: _loginColor,
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
    );
  }
}
