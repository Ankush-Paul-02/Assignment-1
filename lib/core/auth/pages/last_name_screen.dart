import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/user_name_screen.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../widgets/custom_button.dart';

class LastNameScreen extends StatefulWidget {
  const LastNameScreen({super.key});

  @override
  State<LastNameScreen> createState() => _LastNameScreenState();
}

class _LastNameScreenState extends State<LastNameScreen> {
  final TextEditingController _lastNameController = TextEditingController();
  bool isFocus = false;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> storeUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = _lastNameController.text;
    final userData = {'lastname': name};
    await users.doc(user!.uid).update(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const UserNameScreen(),
              ),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: color5,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'What is your last name?',
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
              controller: _lastNameController,
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
                      builder: (context) => const UserNameScreen(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
