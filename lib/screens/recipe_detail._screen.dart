import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recepy_app/models/recipe_model.dart';
import 'package:recepy_app/providers/recipes_provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipeData;
  const RecipeDetailScreen({super.key, required this.recipeData});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipes
        .contains(widget.recipeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipeData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });
              await Provider.of<RecipesProvider>(context, listen: false)
                  .toggleFavoriteStatus(widget.recipeData);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(
                'https://cdn.bolivia.com/gastronomia/2012/10/26/lasana-boliviana-3495.webp'),
            SizedBox(
              height: 8,
            ),
            Text(widget.recipeData.name),
            SizedBox(
              height: 8,
            ),
            Text(widget.recipeData.author),
            SizedBox(
              height: 8,
            ),
            Text('Recipe Steps:'),
            SizedBox(
              height: 8,
            ),
            for (var step in widget.recipeData.recipeSteps)
              Column(
                children: [
                  Text("-$step"),
                  Text("-$step"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
