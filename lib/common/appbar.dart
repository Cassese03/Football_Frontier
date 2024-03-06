// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:football_app/screens/notification_screen.dart';
import 'package:iconsax/iconsax.dart';

class AppbarAll extends StatelessWidget implements PreferredSizeWidget {
  int currentColor;
  AppbarAll({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        icon: const Icon(Iconsax.category),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
