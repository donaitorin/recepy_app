import 'package:flutter/material.dart';
import 'package:recepy_app/components/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          recipesCard(context),
          recipesCard(context),
          recipesCard(context)
        ],
      ),
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

  Widget recipesCard(BuildContext context) {
    return Padding(
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
                    'https://www.recetasnestle.com.ec/sites/default/files/srh_recipes/6594a07290c4cc5ed88f682560cc2e49.jpg',
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
                    'Lasagna',
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
                    'Donai Torin',
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
    );
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
