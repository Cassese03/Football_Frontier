import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'providers/players_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: PlayersProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Footbal Frontier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "PlusJakartaSans",
        scaffoldBackgroundColor: kbackgroundColor,
        appBarTheme: const AppBarTheme(color: kbackgroundColor),
        colorScheme: ColorScheme.fromSeed(
          seedColor: kprimaryColor,
          background: kbackgroundColor,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
