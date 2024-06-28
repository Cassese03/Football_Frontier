import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Giornata extends StatelessWidget {
  int currentColor, giornata;

  Giornata({
    super.key,
    required this.currentColor,
    required this.giornata,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: Color(currentColor),
        child: Row(
          children: [
            const Spacer(),
            Text(
              (giornata != 8 && giornata != 9)
                  ? 'Giornata ${giornata.toString()}'
                  : (giornata == 8)
                      ? 'Semifinale Andata'
                      : 'Semifinale Ritorno',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
