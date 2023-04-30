import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/auth/pages/profile_screen.dart';
import 'package:flutter_assignment/core/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List _items = [
    Text(
      'Screen 1',
      style: TextStyle(
        color: color4,
      ),
    ),
    Text(
      'Screen 2',
      style: TextStyle(
        color: color4,
      ),
    ),
    Text(
      'Screen 3',
      style: TextStyle(
        color: color4,
      ),
    ),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pokee',
        ),
        centerTitle: true,
        backgroundColor: color2,
      ),
      body: Center(
        child: _items.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: color2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: color3,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
