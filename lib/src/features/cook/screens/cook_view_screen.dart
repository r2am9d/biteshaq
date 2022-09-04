import 'package:flutter/material.dart';

class CookViewScreen extends StatelessWidget {
  const CookViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CookViewScreen'),
      ),
      body: const Center(
        child: Text('CookViewScreen'),
      ),
    );
  }
}
