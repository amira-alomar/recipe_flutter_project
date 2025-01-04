// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CookingTipsPage extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {
      'title': 'Keep Your Knives Sharp',
      'details': 'A sharp knife makes cutting safer and easier. Remember to sharpen them regularly.',
      'icon': '🔪',
    },
    {
      'title': 'Taste as You Cook',
      'details': 'Tasting your food as you cook ensures balanced flavors and prevents over-seasoning.',
      'icon': '👅',
    },
    {
      'title': 'Prep Ingredients in Advance',
      'details': 'Chop, measure, and organize ingredients before starting to cook for a smoother process.',
      'icon': '🍅',
    },
    {
      'title': 'Let Meat Rest',
      'details': 'Allow cooked meat to rest for a few minutes to lock in the juices and improve texture.',
      'icon': '🥩',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking Tips',style: TextStyle(color: Color(0xFFdcd2eb)),),
        backgroundColor: Color(0xFF5f2d8c),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            final tip = tips[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  leading: Text(
                    tip['icon']!,
                    style: TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    tip['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5f2d8c),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tip['details']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5f2d8c),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFFdcd2eb),
    );
  }
}
