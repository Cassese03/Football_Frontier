import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WinnerAnimation(),
        ),
      ),
    );
  }
}

class WinnerAnimation extends StatefulWidget {
  @override
  _WinnerAnimationState createState() => _WinnerAnimationState();
}

class _WinnerAnimationState extends State<WinnerAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 24).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gif/fuochi.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Winner text
        Center(
          child: Text(
            'Winner',
            style: TextStyle(
              fontSize: 48 + _animation.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Image below the text
        Positioned(
          bottom: 0,
          child: Image.network('https://ws.footballfrontier.it/img/football_profilo_773787716.jpg'),
        ),
      ],
    );
  }
}
