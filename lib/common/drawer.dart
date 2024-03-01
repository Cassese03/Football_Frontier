import 'package:flutter/material.dart';
import 'package:football_app/screens/login_screen.dart';
import 'package:football_app/screens/main_screen.dart';
import 'package:football_app/screens/settings_screen.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DrawerLorenzo extends StatelessWidget implements PreferredSizeWidget {
  int currentColor;
  DrawerLorenzo({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(currentColor),
      child: SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 25,
                child: Container(
                  child: Image.asset("assets/images/raimon.jpg"),
                ),
              ),
              Expanded(
                flex: 65,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.house,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Home',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              currentTab: 0,
                            ),
                          ),
                        );
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.sports_soccer,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Calendario',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              currentTab: 1,
                            ),
                          ),
                        );
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.stacked_bar_chart_sharp,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Classifica',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              currentTab: 2,
                            ),
                          ),
                        );
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.stadium,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Formazioni',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              currentTab: 3,
                            ),
                          ),
                        );
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.emoji_people,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Account',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Get.to(
                          () => MainScreen(
                            currentTab: 4,
                          ),
                          transition: Transition.rightToLeft,
                          duration: const Duration(seconds: 1),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              currentTab: 4,
                            ),
                          ),
                        );
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Impostazioni',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Get.to(
                          () => const SettingsScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(seconds: 1),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Logout',
                        style: textStyleListTile(),
                      ),
                      onTap: () {
                        Get.to(
                          () => const LoginScreen(),
                          transition: Transition.leftToRight,
                          duration: const Duration(seconds: 1),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  TextStyle textStyleListTile() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    );
  }
}
