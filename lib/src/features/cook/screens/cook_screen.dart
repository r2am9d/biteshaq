import 'package:flutter/material.dart';

class CookScreen extends StatelessWidget {
  const CookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('CookScreen'),
      ),
      body: const Center(
        child: Text('CookScreen'),
      ),
    );
  }
}
