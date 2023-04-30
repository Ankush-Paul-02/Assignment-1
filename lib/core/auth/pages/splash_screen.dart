import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/login_screen.dart';
import 'package:flutter_assignment/core/auth/pages/phone_number_screen.dart';
import 'package:flutter_assignment/core/utils/dimension.dart';
import '../../utils/colors.dart';
import '../widgets/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'pokee'.toUpperCase(),
                style: const TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                CustomSignButton(
                  text: 'CREATE ACCOUNT',
                  onTap: () => Navigator.push(
                    (context),
                    CupertinoPageRoute(
                      builder: (context) => const PhoneNumberScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomSignButton(
                  text: 'SIGN IN',
                  onTap: () => Navigator.push(
                    (context),
                    CupertinoPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
                const Text(
                  "By continuing, you agree to Pokee's Terms & condition and",
                  style: TextStyle(color: color5),
                ),
                const Text(
                  "confirm you have read Pokee's Privacy Policy.",
                  style: TextStyle(color: color5),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
