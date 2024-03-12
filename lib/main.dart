import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/login/login_bloc.dart';
import 'package:football_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/players_provider.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
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
      ),
    );
  }
}
