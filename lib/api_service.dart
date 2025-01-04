import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recipe.dart';

class ApiService {
  final String baseApiUrl = 'https://www.themealdb.com/api/json/v1/1/';

  // Fetch all recipes
  Future<List<Recipe>> fetchRecipes() async {
    final String apiUrl = '${baseApiUrl}search.php?s=';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];
        return meals.map((meal) => Recipe.fromJson(meal)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }

  // Fetch all categories with their images
  Future<List<Map<String, String>>> fetchCategories() async {
  final String apiUrl = '${baseApiUrl}categories.php';
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categories = data['categories'];
      return categories.map<Map<String, String>>((category) {
        return {
          'name': category['strCategory'] as String,
          'imageUrl': category['strCategoryThumb'] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    print('Error fetching categories: $e');
    return [];
  }
}


  // Fetch recipes by category
  Future<List<Recipe>> fetchRecipesByCategory(String category) async {
    final String apiUrl = '${baseApiUrl}filter.php?c=$category';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];
        return meals
            .map((meal) => Recipe(
                  idMeal: meal['idMeal'],
                  name: meal['strMeal'],
                  category: category,
                  area: '',
                  instructions: '',
                  imageUrl: meal['strMealThumb'],
                  ingredients: [],
                  tags: [],
                ))
            .toList();
      } else {
        throw Exception('Failed to load recipes by category');
      }
    } catch (e) {
      print('Error fetching recipes by category: $e');
      return [];
    }
  }

  // Fetch recipe details by ID
  Future<Recipe> fetchRecipeDetails(String idMeal) async {
    final String apiUrl = '${baseApiUrl}lookup.php?i=$idMeal';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meal = data['meals'][0];
        return Recipe.fromJson(meal);
      } else {
        throw Exception('Failed to load recipe details');
      }
    } catch (e) {
      print('Error fetching recipe details: $e');
      throw Exception('Error fetching recipe details');
    }
  }
}
