import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/login/login_bloc.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:flutter/foundation.dart';
import 'package:seo/seo.dart';

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
    if (kIsWeb) {
      // Define MetaSEO object
      MetaSEO meta = MetaSEO();
      // add meta seo data for web app as you want
      meta.author(author: 'Lorenzo Cassese');
      meta.description(
        description:
            'Torneo di Calcio Nola Festa dei Gigli, amatoriale, creato da giovani per divertimento senza scopo di lucro. Giovani talenti gol incredibili nola.Vieni a NOLA da BOMBONERA a divertirti con noi.Il motto è "I giovani per il sociale!"',
      );
      meta.keywords(
        keywords:
            'Torneo, Calcio, Nola, Inazuma,Football,Frontier,Festa,Gigli,Gol,Talento,Diverimento,Incredibile,Amatoriale,Bombonera,Insieme,Sociale',
      );
    }
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: Scaffold(
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
                    Seo.text(
                      text:
                          'Torneo, Calcio, Nola, Inazuma,Football,Frontier,Festa,Gigli,Gol,Talento,Diverimento,Incredibile,Amatoriale,Bombonera,Insieme,Sociale',
                      style: TextTagStyle.h1,
                      child: const Text(''),
                    ),
                    Seo.text(
                      text:
                          'Football Frontier - Benvenuti su footballfrontier.it, il sito dedicato a tutti gli appassionati del torneo amatoriale di calcio a Nola. Qui troverete notizie aggiornate, risultati in tempo reale, analisi esclusive e approfondimenti su tutte le squadre e i giocatori partecipanti. Segui le cronache delle partite, scopri le statistiche dettagliate e rimani informato su tutte le novità e gli eventi speciali legati al torneo. Unisciti alla nostra comunità e vivi da protagonista l\'emozione del calcio amatoriale a Nola con Football Frontier!',
                      style: TextTagStyle.h1,
                      child: const Text(''),
                    ),
                    Seo.text(
                      text: 'Il torneo Nolano',
                      style: TextTagStyle.h1,
                      child: const Text(
                        '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //   const HtmlWidget(
                    //     '''
                    //             <h1>FootballFrontier di Nola</h7>
                    //             <h2>FootballFrontier di Nola</h2>
                    //             <h3>FootballFrontier di Nola</h3>
                    //             <h4>FootballFrontier di Nola</h4>
                    //             <h5>FootballFrontier di Nola</h5>
                    //             <h6>FootballFrontier di Nola</h6>
                    //             ''',
                    //   ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Seo.image(
                          src:
                              "https://footballfrontier.it/assets/assets/images/McDonald.png",
                          alt: 'McDonald x Football Frontier',
                          child: Image.asset(
                            "assets/images/McDonald.png",
                          ),
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
                                    Seo.text(
                                      text: 'Ricordati di me',
                                      style: TextTagStyle.h1,
                                      child: const Text(
                                        'Ricordati di me',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
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
                                    Seo.text(
                                      text: 'Ricordati di me',
                                      style: TextTagStyle.h1,
                                      child: const Text(
                                        'Ricordati di me',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
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
                                    child: Seo.text(
                                      text: 'Login',
                                      style: TextTagStyle.h1,
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
                                ),
                          TextButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    LoginOnTapLoginWithout(
                                      'pubblico@gmail.com',
                                      '1',
                                    ),
                                  );
                            },
                            child: Seo.text(
                              text: 'Accedi ora come anonimo',
                              style: TextTagStyle.h1,
                              child: const Text('Accedi ora come anonimo'),
                            ),
                          )
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
      ),
    );
  }
}
