import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/common/appbar.dart';
import 'package:football_app/common/drawer/drawer.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/capocannoniere/capocannoniere_screen.dart';
import 'package:football_app/screens/main/main_bloc.dart';
import 'package:football_app/screens/referto/referto_screen.dart';
import 'package:football_app/screens/secondaccount/secondaccount_screen.dart';
import 'package:football_app/screens/squad/squad_screen.dart';
import 'package:football_app/screens/stadium_screen.dart';
import 'package:football_app/screens/account/account_screen.dart';
import 'package:football_app/screens/calendar/calendar_screen.dart';
import 'package:football_app/screens/home/home_screen.dart';
import 'package:football_app/screens/standing/standing_screen.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:iconsax/iconsax.dart';

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
  @override
  Widget build(BuildContext context) {
    List screens = [
      const HomeScreen(),
      const CalendarScreen(),
      const StandingScreen(),
      StadiumScreen(),
      AccountScreen(
        idGiocatore: 0,
      ),
      SquadScreen(
        squad: widget.idSquadra ?? 0,
      ),
      SecondAccountScreen(
        idGiocatore: widget.idGiocatore ?? 0,
      ),
      const CapocannoniereScreen(),
      RefertoScreen(),
    ];

    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainInitial) {
            context.read<MainBloc>().add(MainInit());
          }
          if (state is MainLoading) {
            return const Loading(
              duration: Duration(seconds: 1),
            );
          }
          if (state is MainReady) {
            return Scaffold(
              appBar: AppbarAll(
                currentColor: state.currentColor,
              ),
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
                      currentColor: state.currentColor,
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
                      currentColor: state.currentColor,
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
                      currentColor: state.currentColor,
                      title: "Standing",
                      icon: Iconsax.chart,
                      isActive: widget.currentTab == 2,
                      onTap: () {
                        setState(() {
                          widget.currentTab = 2;
                        });
                      },
                    ),
                    // BottomNavItem(
                    //   currentColor: state.currentColor,
                    //   title: "Lineup",
                    //   icon: Icons.stadium,
                    //   isActive: widget.currentTab == 3,
                    //   onTap: () {
                    //     setState(() {
                    //       widget.currentTab = 3;
                    //     });
                    //   },
                    // ),
                    BottomNavItem(
                      currentColor: state.currentColor,
                      title: "Capocannoniere",
                      icon: Icons.sports_soccer,
                      isActive: widget.currentTab == 7,
                      onTap: () {
                        setState(() {
                          widget.currentTab = 7;
                        });
                      },
                    ),
                    BottomNavItem(
                      currentColor: state.currentColor,
                      title: "Referto",
                      icon: Icons.file_copy,
                      isActive: widget.currentTab == 8,
                      onTap: () {
                        setState(() {
                          widget.currentTab = 8;
                        });
                      },
                    ),
                    BottomNavItem(
                      currentColor: state.currentColor,
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
                currentColor: state.currentColor,
              ),
            );
          }
          return const Loading(
            duration: Duration(seconds: 1),
          );
        },
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
