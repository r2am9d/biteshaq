import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameScreen'),
      ),
      body: const Center(
        child: Text('GameScreen'),
      ),
    );
  }
}
