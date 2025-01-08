// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String label;

  CustomButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: const Color(0x1A007FFF),
          border: Border.all(
              color: const Color(
            0xFFEEEEEE,
          )),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset('assets/plus_vector.svg'),
          Text(
            label,
            style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF007FFF)),
          ),
        ],
      ),
    );
  }
}
