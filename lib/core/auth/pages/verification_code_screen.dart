import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/first_name_screen.dart';
import 'package:flutter_assignment/core/auth/pages/phone_number_screen.dart';
import 'package:flutter_assignment/core/utils/colors.dart';
import 'package:flutter_assignment/core/utils/dimension.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      backgroundColor: color1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Enter your verification code',
              style: TextStyle(
                color: color5,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 3),
          VerificationCode(
            textStyle: const TextStyle(fontSize: 20.0, color: color4),
            keyboardType: TextInputType.number,
            length: 6,
            underlineColor: color3,
            cursorColor: color3,
            clearAll: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18.0,
                    color: color3,
                  ),
                  children: [
                    TextSpan(text: "Didn't get the code? "),
                    TextSpan(
                      text: 'Resend',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: color3),
                    ),
                  ],
                ),
              ),
            ),
            onCompleted: (value) async {
              code = value;
              try {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: PhoneNumberScreen.verify, smsCode: code);

                await auth.signInWithCredential(credential);
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const FirstNameScreen(),
                    ),
                    (route) => false);
              } catch (e) {
                print('Wrong OTP');
              }
            },
            onEditing: (value) {},
          ),
        ],
      ),
    );
  }
}
