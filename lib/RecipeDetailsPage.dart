// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeDetailsPage extends StatefulWidget {
  final String recipeId;

  RecipeDetailsPage({required this.recipeId});

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Map<String, dynamic>? recipeDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    final apiUrl = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.recipeId}';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recipeDetails = data['meals'][0];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load recipe details');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeDetails?['strMeal'] ?? 'Recipe Details',style: TextStyle(color: Color(0xFFdcd2eb))),
        backgroundColor: Color(0xFF5f2d8c),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF5f2d8c)))
          : recipeDetails == null
              ? Center(child: Text('No details found'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Image and Title
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          recipeDetails!['strMealThumb'] ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported, size: 100, color: Color(0xFF5f2d8c)),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        recipeDetails!['strMeal'] ?? 'Unknown Recipe',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5f2d8c),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      // Ingredients Section
                      Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5f2d8c),
                        ),
                      ),
                      SizedBox(height: 12),
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildIngredientList(recipeDetails!),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      // Instructions Section
                      Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5f2d8c),
                        ),
                      ),
                      SizedBox(height: 12),
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            recipeDetails!['strInstructions'] ??
                                'No instructions available',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      backgroundColor: Color(0xFFdcd2eb),
    );
  }

  List<Widget> _buildIngredientList(Map<String, dynamic> details) {
    List<Widget> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = details['strIngredient$i'];
      final measure = details['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '• $ingredient (${measure ?? ''})',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ),
        );
      }
    }
    return ingredients;
  }
}
