import 'package:flutter/material.dart';

class Stadium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green-stadium.jpg'),
        ),
      ),
    );
  }
}
