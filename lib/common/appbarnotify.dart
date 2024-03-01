import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarNotify extends StatelessWidget implements PreferredSizeWidget {
  int currentColor;
  AppbarNotify({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        children: [
          const Spacer(),
          const Text(
            "F",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.sports_soccer,
            color: Color(currentColor),
          ),
          Icon(
            Icons.sports_soccer,
            color: Color(currentColor),
          ),
          const Text(
            "tball  ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Frontier",
            style: TextStyle(
              color: Color(currentColor),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.transparent,
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_active_outlined,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
