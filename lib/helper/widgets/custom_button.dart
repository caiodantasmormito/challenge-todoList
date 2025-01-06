// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String label;

  CustomButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
          color: const Color(0xFF449988),
          border: Border.all(
              color: const Color(
            0xFFEEEEEE,
          )),
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
