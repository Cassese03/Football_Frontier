import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/login/login_bloc.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:football_app/widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentColor = kprimaryColor.value;

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInit) {
              context.read<LoginBloc>().add(LoginCheckRemember());
            }
            if (state is LoginLoading) {
              return const Loading(
                duration: Duration(seconds: 1),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Image.asset(
                        "assets/images/McDonald.png",
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
                            obscureText: false,
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
                          child: FancyPasswordField(
                            style: TextStyle(
                              decorationColor: Color(currentColor),
                              fontSize: 18,
                            ),
                            hasStrengthIndicator: false,
                            controller: password,
                            decoration: InputDecoration(
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
                        (state is LoginRemember)
                            ? Row(
                                children: [
                                  Checkbox(
                                    value: state.rememberMe,
                                    onChanged: (bool? value) async {
                                      if (value != null) {
                                        context.read<LoginBloc>().add(
                                              LoginOnTapRemember(value),
                                            );
                                      }
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
                              )
                            : Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (bool? value) async {
                                      if (value != null) {
                                        context.read<LoginBloc>().add(
                                              LoginOnTapRemember(value),
                                            );
                                      }
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
                        (state is LoginLoading)
                            ? const Loading(
                                duration: Duration(seconds: 1),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(currentColor),
                                  ),
                                  onPressed: () async {
                                    context.read<LoginBloc>().add(
                                          LoginOnTapLogin(
                                            email.text,
                                            password.text,
                                          ),
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
            );
          },
          listener: (context, state) {
            if (state is LoginFailed) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    state.error,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Riprova'),
                    ),
                  ],
                ),
              );
            }
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(currentTab: 0),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
