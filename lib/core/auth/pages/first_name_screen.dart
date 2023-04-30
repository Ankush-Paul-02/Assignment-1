import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/last_name_screen.dart';
import 'package:flutter_assignment/core/utils/colors.dart';
import 'package:flutter_assignment/core/utils/dimension.dart';
import '../widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstNameScreen extends StatefulWidget {
  const FirstNameScreen({super.key});

  @override
  State<FirstNameScreen> createState() => _FirstNameScreenState();
}

class _FirstNameScreenState extends State<FirstNameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  bool isFocus = false;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> storeUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = _firstNameController.text;
    final userData = {'firstname': name};
    await users.doc(user!.uid).set(userData);
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
              'What is your first name?',
              style: TextStyle(
                color: color5,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 2, vertical: defaultPadding),
            child: TextFormField(
              controller: _firstNameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color3),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onTap: () {
                setState(() {
                  isFocus = true;
                });
              },
              onFieldSubmitted: (value) {
                setState(() {
                  isFocus = false;
                });
              },
              style: const TextStyle(
                color: color4,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: CustomSignButton(
                text: 'Next',
                onTap: () {
                  storeUserData();
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LastNameScreen(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
