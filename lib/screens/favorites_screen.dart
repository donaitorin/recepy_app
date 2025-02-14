import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recepy_app/components/recipe_card.dart';
import 'package:recepy_app/models/recipe_model.dart';
import 'package:recepy_app/providers/recipes_provider.dart';
import 'package:recepy_app/screens/recipe_detail._screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          final recipesFavorites = provider.favoriteRecipes;
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
                color: Colors.grey,
              ),
            );
          }
          if (recipesFavorites.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noRecipes),
            );
          }

          return ListView.builder(
            itemCount: recipesFavorites.length,
            itemBuilder: (context, index) {
              return FavoriteRecipeCard(recipe: recipesFavorites[index]);
            },
          );
        },
      ),
    ));
  }
}

class FavoriteRecipeCard extends StatelessWidget {
  final Recipe recipe;
  const FavoriteRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RecipeDetailScreen(recipeData: recipe);
        }));
      },
      child: Semantics(
          label: 'Recepy Card',
          hint: 'Touch it to see details of ${recipe.name}',
          child: RecipeCard(recipe: recipe)),
    );
  }
}
