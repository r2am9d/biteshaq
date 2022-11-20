import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('FavoriteScreen'),
      ),
      body: const Center(
        child: Text('FavoriteScreen'),
      ),
    );
  }
}
