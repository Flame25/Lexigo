import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewProfilePage();
}

class _ViewProfilePage extends State<ViewProfilePage> {
  Map<String, dynamic>? userInfo;
  String? userId = "1";
  bool isLoading = true;
  bool isLogin = false;

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> loadSession() async {
    isLoading = true;
    isLogin = false;

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString("user_id");
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/user/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      setState(() {
        userInfo = parsedJson["user_info"];
        isLogin = true;
        isLoading = false;
      });
    } else if (response.statusCode == 400) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("HAI");
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan gradien
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFC200), Color(0xFFFFDE00)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 60,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            size: 28, color: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ),
                    const Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (!isLogin && !isLoading)
                AlertDialog(
                  title: Text('You are not logged in'),
                  content: Text('Please log in to continue.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // You can replace this with your actual login navigation logic
                        Navigator.pop(context); // Close the dialog
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('Log In'),
                    ),
                  ],
                ),

              if (isLoading)
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  ],
                ),

              if (isLogin && !isLoading)
                Column(
                  children: [
                    // Profil Foto
                    Center(
                      child: CircleAvatar(
                        radius: 87.5,
                        backgroundImage:
                            NetworkImage(userInfo!["profile_images"] + "?time=${DateTime.now().millisecondsSinceEpoch}"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 30),

                    if (isLogin && !isLoading)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                _buildProfileDetail(
                                  label: "Username",
                                  value: userInfo!['username'] ?? "N/A",
                                  icon: Icons.person,
                                ),
                                const SizedBox(height: 20),
                                _buildProfileDetail(
                                  label: "Email",
                                  value: userInfo!['email'] ?? "N/A",
                                  icon: Icons.email,
                                ),
                                const SizedBox(height: 20),
                                _buildProfileDetail(
                                  label: "Password",
                                  value: '*' *
                                      userInfo!['password'].toString().length,
                                  icon: Icons.lock,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Tombol Edit Profile
                          Center(
                            child: CustomButton(
                              text: "Edit Profile",
                              width: 200,
                              backgroundColor: const Color(0xFF003566),
                              shadowColor: const Color(0xFF04153B),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, '/editprofile')
                                    .then((result) {
                                  if (result == true) {
                                    loadSession();
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Tombol Logout dan Delete Account
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    clearSession();
                                    Navigator.pushNamed(context, '/')
                                        .then((result) {
                                      if (result == true) {
                                        loadSession();
                                      }
                                    });
                                  },
                                  child: const Text(
                                    'Logout',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: const Text(
                                    'Delete My Account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFEC0B1B),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(
      {required String label, required String value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF003566), size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF003566),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
