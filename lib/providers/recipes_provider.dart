import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recepy_app/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Recipe> recipes = [];
  List<Recipe> favoriteRecipes = [];

  Future<List<dynamic>> fetchRecipes() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('http://localhost:3001/recipes');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes =
            List<Recipe>.from(data['recipes'].map((x) => Recipe.fromJson(x)));
      }
      print('Status: ${response.statusCode}');
      return recipes;
    } catch (e) {
      print('Error: $e');
      return recipes;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {
    final isFavorite = favoriteRecipes.contains(recipe);
    try {
      final url = Uri.parse('http://localhost:3001/favorites/');
      final response = isFavorite
          ? await http.delete(url, body: jsonEncode({"id": recipe.id}))
          : await http.post(url, body: jsonEncode({"id": recipe.id}));

      if (response.statusCode == 200) {
        if (isFavorite) {
          favoriteRecipes.remove(recipe);
        } else {
          favoriteRecipes.add(recipe);
        }
        notifyListeners();
      } else {
        throw Exception('Failed to toggle favorite status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
