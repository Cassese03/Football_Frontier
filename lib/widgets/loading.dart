import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, required this.duration});

  final Duration duration;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0.75, end: 1.50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(
        reverse:
            true); // Ripeti l'animazione in avanti e all'indietro all'infinito
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(
            "assets/images/McDonald.png",
          ),
        ),
      ),
    );
  }
}
