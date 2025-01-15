import 'package:flutter/material.dart';
import '../components/custom_button.dart';

class ViewProfilePage extends StatelessWidget {
  final Map<String, String> userData;

  const ViewProfilePage({super.key, required this.userData});

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
                        'My Profile',
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
              child: CircleAvatar(
                radius: 87.5,
                backgroundImage: const NetworkImage("https://via.placeholder.com/175"),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 30),

            // Detail Profil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProfileDetail(
                    label: "Username",
                    value: userData['username'] ?? "N/A",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildProfileDetail(
                    label: "Email",
                    value: userData['email'] ?? "N/A",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  _buildProfileDetail(
                    label: "Password",
                    value: userData['password'] ?? "************",
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
                  Navigator.pushNamed(context, '/editProfile');
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
                      print('Logout clicked');
                    },
                    child: const Text(
                      'Logout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      print('Delete My Account clicked');
                    },
                    child: const Text(
                      'Delete My Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEC0B1B),
                        fontSize: 20,
                        fontFamily: 'Baloo',
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
        ),
      ),
    );
  }

  Widget _buildProfileDetail({required String label, required String value, required IconData icon}) {
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
