import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class CustomSignButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomSignButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: const BoxDecoration(
          color: color2,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: color4,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}