import 'package:flutter/material.dart';
import '../components/input_field.dart';
import '../components/custom_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Nilai default untuk input fields
    usernameController.text = 'Jihan Aurelia';
    emailController.text = 'jihan@gmail.com';
    passwordController.text = '************';
    dateOfBirthController.text = '23/05/1995';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
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
                          fontFamily: 'Baloo',
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
                  const CircleAvatar(
                    radius: 87.5,
                    backgroundImage: NetworkImage("https://via.placeholder.com/175"),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFF003566),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        onPressed: () {
                          // Tambahkan fungsi ubah foto
                          print("Change photo clicked");
                        },
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
                  InputField(
                    label: "Date of Birth",
                    placeholder: "Enter your date of birth",
                    controller: dateOfBirthController,
                  ),
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/viewProfile', arguments: {
                        'username': usernameController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'dateOfBirth': dateOfBirthController.text,
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Cancel Changes",
                    width: 200,
                    backgroundColor: const Color(0xFFFFFFFF),
                    shadowColor: const Color(0xFF58A700),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/viewProfile');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}