import 'package:flutter/material.dart';
import 'package:football_app/common/bloc/drawer.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/squad_screen.dart';
import 'package:football_app/screens/stadium_screen.dart';
import 'package:football_app/screens/account/account_screen.dart';
import 'package:football_app/screens/calendar_screen.dart';
import 'package:football_app/screens/home_screen.dart';
import 'package:football_app/screens/standing_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  int currentTab;
  int? idGiocatore;
  int? idSquadra;
  MainScreen({
    super.key,
    required this.currentTab,
    this.idGiocatore,
    this.idSquadra,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentColor = kprimaryColor.value;
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getInt('primaryColor');
    if (check != null) {
      setState(() {
        currentColor = check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List screens = [
      const HomeScreen(),
      const CalendarScreen(),
      const StandingScreen(),
      StadiumScreen(),
      AccountScreen(
        idGiocatore: widget.idGiocatore ?? 0,
      ),
      SquadScreen(
        squad: widget.idGiocatore ?? 0,
      ),
    ];

    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: kbackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.grey.shade200),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              currentColor: currentColor,
              title: "Home",
              icon: Iconsax.home,
              isActive: widget.currentTab == 0,
              onTap: () {
                setState(() {
                  widget.currentTab = 0;
                });
              },
            ),
            BottomNavItem(
              currentColor: currentColor,
              title: "Calender",
              icon: Iconsax.calendar_1,
              isActive: widget.currentTab == 1,
              onTap: () {
                setState(() {
                  widget.currentTab = 1;
                });
              },
            ),
            BottomNavItem(
              currentColor: currentColor,
              title: "Standing",
              icon: Iconsax.chart,
              isActive: widget.currentTab == 2,
              onTap: () {
                setState(() {
                  widget.currentTab = 2;
                });
              },
            ),
            BottomNavItem(
              currentColor: currentColor,
              title: "Lineup",
              icon: Icons.stadium,
              isActive: widget.currentTab == 3,
              onTap: () {
                setState(() {
                  widget.currentTab = 3;
                });
              },
            ),
            BottomNavItem(
              currentColor: currentColor,
              title: "Account",
              icon: Iconsax.profile_circle,
              isActive: widget.currentTab == 4,
              onTap: () {
                setState(() {
                  widget.currentTab = 4;
                });
              },
            ),
          ],
        ),
      ),
      body: screens[widget.currentTab],
      drawer: DrawerLorenzo(
        currentColor: currentColor,
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function() onTap;
  final IconData icon;
  final int currentColor;
  const BottomNavItem({
    super.key,
    required this.title,
    required this.currentColor,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? Color(currentColor) : kbackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey.shade400,
            ),
            isActive
                ? Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
