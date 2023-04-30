import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/verification_code_screen.dart';
import 'package:flutter_assignment/core/auth/widgets/custom_button.dart';
import 'package:flutter_assignment/core/utils/colors.dart';
import 'package:flutter_assignment/core/utils/dimension.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  static String verify = "";

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController countryCode = TextEditingController();
  var phoneNumber = "";
  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Enter your phone number',
              style: TextStyle(
                color: color5,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 3),
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: color2,
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) => phoneNumber = value,
                style: const TextStyle(
                  color: color4,
                  fontSize: 22,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  prefix: Text(
                    '+91 - ',
                    style: TextStyle(color: color4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Text(
            'We will send you a verification code',
            style: TextStyle(
              color: color4,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            child: CustomSignButton(
              text: 'Next',
              onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: countryCode.text + phoneNumber,
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    PhoneNumberScreen.verify = verificationId;
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const VerificationCodeScreen(),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
