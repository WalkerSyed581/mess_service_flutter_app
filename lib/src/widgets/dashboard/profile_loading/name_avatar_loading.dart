import 'package:flutter/material.dart';

class NameAndAvatarLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          ClipPath(
            clipper: AvatarClipper(),
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                // color: darkColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 11,
            top: 30,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFEEEEEE),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 180,
                      color: const Color(0xFFEEEEEE),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20,
                      width: 220,
                      color: const Color(0xFFEEEEEE),
                    ),
                    const SizedBox(height: 8)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
