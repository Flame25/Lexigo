import 'package:flutter/material.dart';
import '../utils/assets.dart';

class Header extends StatelessWidget {
  final String title;
  final String profileIcon;
  final VoidCallback onProfileTap;

  const Header({
    super.key,
    required this.title,
    required this.profileIcon,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEAAD49), Color(0xFFFFC200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // color: Color(0xFFEAAD49),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          // Logo Star di kiri atas
          Positioned(
            top: 60,
            left: 20,
            child: Image.asset(
              AppAssets.starLogoPng, // Menggunakan path dari AppAssets
              height: 35,
              width: 35,
              fit: BoxFit.cover,
            ),
          ),
          // Text judul di tengah atas
          Positioned(
            top: 70,
            right: 70,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Ikon profil di kanan atas
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Image.asset(
                profileIcon, // Menggunakan path dari parameter
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
