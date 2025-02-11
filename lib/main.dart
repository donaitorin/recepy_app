import 'package:flutter/material.dart';
import 'package:recepy_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'el title',
      home: RecipeBook(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: Text(
                'Recepy Book',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      text: 'Home',
                    )
                  ]),
            ),
            body: TabBarView(children: [
              HomeScreen(),
            ])));
  }
}
