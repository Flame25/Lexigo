import 'package:flutter/material.dart';
import '../components/input_field.dart';
import '../components/custom_button.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  bool isLoading = true;
  bool isLogin = false;
  String? userId = "1";
  Map<String, dynamic>? userInfo;
  bool isLoadingUpdate = true;

  @override
  void initState() {
    super.initState();
    // Nilai default untuk input fields
    loadSession();
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
          selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage == null) return;

    // Convert image to base64
    final imageBytes = await selectedImage!.readAsBytes();
    final base64String = base64Encode(imageBytes);

    // Send base64 string to Flask API
    final response = await http.post(
      Uri.parse('https://lexigo-api.codebloop.my.id/upload_image'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'image': base64String, 'user_id': userId}),
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Failed to upload image');
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Test the email against the regular expression
    return emailRegExp.hasMatch(email);
  }

  Future<void> updateUser() async {
    setState(() {
        isLoadingUpdate = true;
    });

    if (!isValidEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Input a valid email'),
        ),
      );
    } else {
      final response = await http.post(
        Uri.parse('https://lexigo-api.codebloop.my.id/user/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
            'username': usernameController.text,
            'password': passwordController.text,
            'email': emailController.text,
            'user_id': userId
        }),
      );

      setState(() {
          isLoadingUpdate = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Success') {
          // Navigate to the next page or show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Update Successful'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['message'] ?? 'Update Failed'),
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
      Uri.parse('https://lexigo-api.codebloop.my.id/user/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      setState(() {
          userInfo = parsedJson["user_info"];
          isLogin = true;
          isLoading = false;
          usernameController.text = userInfo?["username"] ?? "Jihan";
          emailController.text = userInfo?["email"] ?? "jihan@gmail.com";
          passwordController.text = userInfo?['password'] ?? "password";
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
          child: isLoading
          ? const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ],
            ),
          )
          : Column(
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
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ),
                    const Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Profil Foto
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 87.5,
                      backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!) as ImageProvider
                      : NetworkImage(userInfo!["profile_images"] +
                        "?time=${DateTime.now().millisecondsSinceEpoch}"),
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFF003566),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt,
                            size: 16, color: Colors.white),
                          onPressed: pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Input Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    InputField(
                      label: "Username",
                      placeholder: "Enter your username",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Email",
                      placeholder: "Enter your email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Password",
                      placeholder: "Enter your password",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Tombol Save dan Cancel
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      text: "Save Changes",
                      width: 200,
                      backgroundColor: const Color(0xFF003566),
                      shadowColor: const Color(0xFF04153B),
                      textColor: Colors.white,
                      onPressed: () async{
                        // Run both functions concurrently
                        Future<void> function1 = updateUser();
                        Future<void> function2 = uploadImage();
                        
                        // Wait for both functions to finish
                        await Future.wait([function1, function2]);
                        Navigator.pop(context, true);
                    }),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Cancel Changes",
                      width: 200,
                      backgroundColor: const Color(0xFFFFFFFF),
                      shadowColor: const Color(0xFF58A700),
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
