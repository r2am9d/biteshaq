import 'package:flutter/material.dart';

class RecipeViewScreen extends StatelessWidget {
  const RecipeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('RecipeViewScreen'),
      ),
      body: const Center(
        child: Text('RecipeViewScreen'),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
            ),
          ),
          child: const Center(
            child: Text('QWEQWEQWEQWE'),
          ),
        ),
      ],
    );
  }
}
