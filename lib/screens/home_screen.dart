import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recepy_app/components/custom_text_field.dart';
import 'package:recepy_app/components/recipe_card.dart';
import 'package:recepy_app/models/recipe_model.dart';
import 'package:recepy_app/providers/recipes_provider.dart';
import 'package:recepy_app/screens/recipe_detail._screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);
    if (recipesProvider.isLoading) {
      recipesProvider.fetchRecipes();
    }

    return Scaffold(
      body: Consumer<RecipesProvider>(builder: (context, provider, child) {
        final recipes = provider.recipes;
        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              color: Colors.grey,
            ),
          );
        }
        if (recipes.isEmpty) {
          return Center(
            child: Text('No recipes found'),
          );
        }
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(recipe: recipes[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showButton(context);
        },
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showButton(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: RecipeForm(),
            ));
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final recipeNameController = TextEditingController();
    final authorController = TextEditingController();
    final imageUrlController = TextEditingController();
    final recipeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Text(
              'Add New Recipe',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'Quicksand', color: Colors.orange),
            ),
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              label: 'Recipe Name',
              controller: recipeNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
            ),
            CustomTextField(
              label: 'Author',
              controller: authorController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an author';
                }
                return null;
              },
            ),
            CustomTextField(
                label: 'Image Url',
                controller: imageUrlController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image url';
                  }
                  return null;
                }),
            CustomTextField(
                maxLines: 5,
                label: 'Recipe',
                controller: recipeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a recipe';
                  }
                  return null;
                }),
            SizedBox(
              height: 16,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add Recipe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required String label}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1),
          )),
    );
  }
}
