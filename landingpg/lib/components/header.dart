import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        color: Color(0xFFEAAD49),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            child: SvgPicture.asset(
              'assets/star-logo.png',
              height: 35,
            ),
          ),
          Positioned(
            top: 70,
            right: 70,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: onProfileTap,
              child: SvgPicture.asset(
                profileIcon,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
