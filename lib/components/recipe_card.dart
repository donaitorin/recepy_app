import 'package:flutter/material.dart';
import 'package:recepy_app/models/recipe_model.dart';
import 'package:recepy_app/screens/recipe_detail._screen.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RecipeDetailScreen(
            recipeData: recipe,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: [
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://cdn.bolivia.com/gastronomia/2012/10/26/lasana-boliviana-3495.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 26,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 2,
                      width: 75,
                      color: Colors.orange,
                    ),
                    Text(
                      "By ${recipe.author}",
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
