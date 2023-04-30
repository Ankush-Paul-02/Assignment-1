import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/home_screen.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../widgets/custom_button.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool isFocus = false;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isTaken = false;

  void _submitForm() async {
    String username = _userNameController.text;
    bool isUsernameTaken = await _isUsernameTaken(username);
    isTaken = isUsernameTaken;

    if (!isUsernameTaken) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'username': username});
    }
  }

  Future<bool> _isUsernameTaken(String username) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
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
              'Username',
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
              controller: _userNameController,
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
                _submitForm();
                isTaken == false
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Username is already taken')),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
