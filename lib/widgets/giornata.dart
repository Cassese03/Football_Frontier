import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Giornata extends StatelessWidget {
  int currentColor;

  Giornata({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: Color(currentColor),
        child: const Row(
          children: [
            Spacer(),
            Text(
              'Giornata 24',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
