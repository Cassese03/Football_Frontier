import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/common/drawer/drawer_bloc.dart';
import 'package:football_app/screens/login/login_screen.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:football_app/screens/settings/settings_screen.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../regolamento/regolamento.dart';

// ignore: must_be_immutable
class DrawerLorenzo extends StatelessWidget implements PreferredSizeWidget {
  int currentColor;
  DrawerLorenzo({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerBloc(),
      child: BlocConsumer<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerLoading) {
            return const Loading(
              duration: Duration(seconds: 1),
            );
          }
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
                      child: Image.asset("assets/images/McDonald.png"),
                    ),
                    Expanded(
                      flex: 65,
                      child: ListView(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Iconsax.home,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Home',
                              style: textStyleListTile(),
                            ),
                            onTap: () {
                              context.read<DrawerBloc>().add(DrawerTapHome());
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Iconsax.calendar_1,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Calendario',
                              style: textStyleListTile(),
                            ),
                            onTap: () {
                              context
                                  .read<DrawerBloc>()
                                  .add(DrawerTapCalendar());
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Iconsax.status_up,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Classifica',
                              style: textStyleListTile(),
                            ),
                            onTap: () {
                              context
                                  .read<DrawerBloc>()
                                  .add(DrawerTapStanding());
                            },
                          ),
                          // ListTile(
                          //   leading: const Icon(
                          //     Icons.stadium,
                          //     color: Colors.black,
                          //   ),
                          //   title: Text(
                          //     'Formazioni',
                          //     style: textStyleListTile(),
                          //   ),
                          //   onTap: () {
                          //     context
                          //         .read<DrawerBloc>()
                          //         .add(DrawerTapLineups());
                          //   },
                          // ),
                          ListTile(
                            leading: const Icon(
                              Iconsax.profile_circle,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Account',
                              style: textStyleListTile(),
                            ),
                            onTap: () {
                              // Get.to(
                              //   () => MainScreen(
                              //     currentTab: 4,
                              //   ),
                              //   transition: Transition.rightToLeft,
                              //   duration: const Duration(seconds: 1),
                              // );
                              context
                                  .read<DrawerBloc>()
                                  .add(DrawerTapAccount());
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
                              //Get.to(
                              //  () => const SettingsScreen(),
                              //  transition: Transition.rightToLeft,
                              //  duration: const Duration(seconds: 1),
                              //);
                              context
                                  .read<DrawerBloc>()
                                  .add(DrawerTapSettings());
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Regolamento',
                              style: textStyleListTile(),
                            ),
                            onTap: () {
                              //Get.to(
                              //  () => const SettingsScreen(),
                              //  transition: Transition.rightToLeft,
                              //  duration: const Duration(seconds: 1),
                              //);
                              context
                                  .read<DrawerBloc>()
                                  .add(DrawerTapRegolamento());
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
                            onTap: () async {
                              //Get.to(
                              //  () => const LoginScreen(),
                              //  transition: Transition.leftToRight,
                              //  duration: const Duration(seconds: 1),
                              //);

                              context.read<DrawerBloc>().add(DrawerTapLogout());
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
        },
        listener: (BuildContext context, DrawerState state) {
          if (state is DrawerTapped) {
            scaffoldKey.currentState!.closeDrawer();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  currentTab: state.currentTab,
                ),
              ),
            );
          }
          if (state is DrawerTappedSettings) {
            scaffoldKey.currentState!.closeDrawer();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          }
          if (state is DrawerTappedRegolamento) {
            scaffoldKey.currentState!.closeDrawer();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegolamentoScreen(),
              ),
            );
          }
          if (state is DrawerTappedLogout) {
            scaffoldKey.currentState!.closeDrawer();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        },
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
