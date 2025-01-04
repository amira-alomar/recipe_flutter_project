// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'home.dart'; // Replace with your home page file
import 'categories.dart'; // Replace with your categories page file
import 'tips.dart'; // Replace with the cooking tips page file
import 'calorie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking App',
      theme: ThemeData(
        primaryColor: Color(0xFF5f2d8c),
        scaffoldBackgroundColor: Color(0xFFdcd2eb),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    WelcomeScreen(),
    CategoriesPage(),
    CookingTipsPage(),
    CalorieCalculator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF5f2d8c),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        elevation: 8.0, // Elevation for shadow effect
        type: BottomNavigationBarType.fixed, // Fixes item width and layout
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calories',
          ),
        ],
      ),
    );
  }
}
