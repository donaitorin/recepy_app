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

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              _controller.forward();
            },
            icon: ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                )),
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
