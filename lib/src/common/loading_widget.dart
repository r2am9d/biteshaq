import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
