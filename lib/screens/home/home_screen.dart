import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/live_match_box.dart';
import 'package:football_app/widgets/loading.dart';

import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeReady) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text(
                          "Prossime Partite",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kbackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20, color: Colors.grey.shade200),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/pl.png",
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                "Football Frontier",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                CupertinoIcons.chevron_down,
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...state.returned.entries.expand(
                          (entry) {
                            if (entry.key == 'partite_future') {
                              return entry.value.map(
                                (e) {
                                  return LiveMatchBox(
                                    idPartita:
                                        int.parse(e["id_partita"].toString()),
                                    awayGoal: int.parse(e["Gol_Ospite"]),
                                    homeGoal: int.parse(e["Gol_Casa"]),
                                    time: 0,
                                    awayLogo: (e["Immagine_Ospite"] == null)
                                        ? "assets/images/raimon.jpg"
                                        : e["Immagine_Ospite"],
                                    homeLogo: (e["Immagine_Casa"] == null)
                                        ? "assets/images/raimon.jpg"
                                        : e["Immagine_Casa"],
                                    awayTitle: e["Squadra_Ospite"].toString(),
                                    homeTitle: e["Squadra_Casa"].toString(),
                                    giornata: e["giornata"],
                                    color: kboxColor,
                                    textColors: Colors.white,
                                    backgroundImage: const DecorationImage(
                                      image: AssetImage("assets/images/pl.png"),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomLeft,
                                      opacity: 0.3,
                                    ),
                                  );
                                },
                              ).toList();
                            } else {
                              return <Widget>[];
                            }
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text(
                          "Partite Concluse",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kbackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20, color: Colors.grey.shade200),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/pl.png",
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                "Football Frontier",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                CupertinoIcons.chevron_down,
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...state.returned.entries.expand(
                          (entry) {
                            if (entry.key == 'partite_giocate') {
                              return entry.value.map(
                                (e) {
                                  return LiveMatchBox(
                                    idPartita: e["id_partita"],
                                    awayGoal: int.parse(e["Gol_Ospite"]),
                                    homeGoal: int.parse(e["Gol_Casa"]),
                                    time: 90,
                                    awayLogo: (e["Immagine_Ospite"] == null)
                                        ? "assets/images/raimon.jpg"
                                        : e["Immagine_Ospite"],
                                    homeLogo: (e["Immagine_Casa"] == null)
                                        ? "assets/images/raimon.jpg"
                                        : e["Immagine_Casa"],
                                    awayTitle: e["Squadra_Ospite"].toString(),
                                    homeTitle: e["Squadra_Casa"].toString(),
                                    giornata: e["giornata"],
                                    color: kboxColor,
                                    textColors: Colors.white,
                                    backgroundImage: const DecorationImage(
                                      image: AssetImage("assets/images/pl.png"),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomLeft,
                                      opacity: 0.3,
                                    ),
                                  );
                                },
                              ).toList();
                            } else {
                              return <Widget>[];
                            }
                          },
                        ).toList(),
                      ],
                    ),
                  )
                ],
              );
            }
            if (state is HomeInitial) {
              context.read<HomeBloc>().add(HomeInit());
            }
            if (state is HomeLoading) {
              return const Loading(
                duration: Duration(seconds: 1),
              );
            }
            return const Loading(
              duration: Duration(seconds: 1),
            );
          },
        ),
      ),
    );
  }
}
