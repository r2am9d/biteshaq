import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.warning,
              color: Colors.white,
              size: 86,
            ),
            Text(
              'Unexpected error occured.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
