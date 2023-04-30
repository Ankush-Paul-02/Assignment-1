import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/splash_screen.dart';
import 'package:flutter_assignment/core/utils/colors.dart';
import 'package:flutter_assignment/core/utils/dimension.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  late File _image;
  bool _isLoading = false;
  String _imageUrl = '';

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${DateTime.now().toString()}');
      final UploadTask uploadTask = ref.putFile(File(pickedFile.path));
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = (await downloadUrl.ref.getDownloadURL());
      setState(() {
        _isLoading = false;
        _imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String username;
    return Scaffold(
      backgroundColor: color1,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
                    color: color4,
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SplashScreen(),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: color1,
                            ),
                          ),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: color1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: defaultPadding * 6,
                      backgroundImage: _imageUrl.isEmpty
                          ? const NetworkImage(
                              'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c29mdHdhcmUlMjBkZXZlbG9wZXIlMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')
                          : NetworkImage(_imageUrl) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => _getImage(),
                        icon: const Icon(Icons.camera, color: color5),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return const Text('No data found.');
                    }
                    final name = data['firstname'] as String?;
                    if (name == null) {
                      return const Text('No name found.');
                    }
                    return Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: color4,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return const Text('No data found.');
                    }
                    final username = data['username'] as String?;
                    if (username == null) {
                      return const Text('No username found.');
                    }
                    return Center(
                      child: Text(
                        username,
                        style: const TextStyle(
                          color: color4,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
