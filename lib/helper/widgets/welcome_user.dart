import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Welcome, ',
          style: GoogleFonts.urbanist(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'John.',
          style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF007FFF)),
        ),
      ],
    );
  }
}
