// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'recipe.dart';
import 'RecipeDetailsPage.dart';

class RecipesPage extends StatefulWidget {
  final String category;

  RecipesPage({required this.category});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final ApiService apiService = ApiService();
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipesByCategory();
  }

  void fetchRecipesByCategory() async {
    final fetchedRecipes = await apiService.fetchRecipesByCategory(widget.category);
    setState(() {
      recipes = fetchedRecipes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Recipes',style: TextStyle(color: Color(0xFFdcd2eb)),),
        backgroundColor: Color(0xFF5f2d8c),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Color(0xFF5f2d8c)),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12.0),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 4.0,
                      shadowColor: Color(0xFF5f2d8c).withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported, size: 50, color: Color(0xFF5f2d8c)),
                          ),
                        ),
                        title: Text(
                          recipe.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5f2d8c),
                          ),
                        ),
                        subtitle: Text(
                          'Tap to view details',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF5f2d8c)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailsPage(recipeId: recipe.idMeal),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      backgroundColor: Color(0xFFdcd2eb),
    );
  }
}
