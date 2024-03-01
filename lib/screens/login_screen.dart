import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentColor = kprimaryColor.value;
  bool rememberMe = false;
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getInt('primaryColor');
    var remember = prefs.getBool('rememberMe');
    if (check != null && remember != null) {
      setState(() {
        currentColor = check;
        rememberMe = remember;
      });
    }
    if (check != null) {
      setState(() {
        currentColor = check;
      });
    }
    if (remember != null) {
      setState(() {
        rememberMe = remember;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Image.asset(
                  "assets/images/raimon.jpg",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(
                        decorationColor: Color(currentColor),
                        fontSize: 18,
                      ),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Color(currentColor),
                        iconColor: Color(currentColor),
                        focusColor: Color(currentColor),
                        hoverColor: Color(currentColor),
                        labelText: 'Email',
                        hintText: 'Inserisci la tua Email',
                        icon: const Icon(
                          Icons.people,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: isObscured,
                      style: TextStyle(
                        decorationColor: Color(currentColor),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: (isObscured)
                              ? const Icon(
                                  Icons.visibility_off,
                                )
                              : const Icon(
                                  Icons.visibility,
                                ),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        ),
                        fillColor: Color(currentColor),
                        iconColor: Color(currentColor),
                        focusColor: Color(currentColor),
                        hoverColor: Color(currentColor),
                        labelText: 'Password',
                        hintText: 'Inserisci la tua Password',
                        icon: const Icon(
                          Icons.password,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool(
                            'rememberMe',
                            value!,
                          );
                          setState(() {
                            rememberMe = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Ricordati di me',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(currentColor),
                      ),
                      onPressed: () async {
                        if (email.text == '') {
                          return showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text(
                                'Errore!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                textAlign: TextAlign.center,
                                'Email mancante.\tPrego inserire una Email!',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Ok',
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        if (password.text == '') {
                          return showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text(
                                'Errore!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                textAlign: TextAlign.center,
                                'Password mancante.\tPrego inserire una password!',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Ok',
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        Get.to(
                          () => MainScreen(currentTab: 0),
                          transition: Transition.rightToLeft,
                          duration: const Duration(seconds: 1),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
