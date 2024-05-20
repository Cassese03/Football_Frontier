import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/capocannoniere/capocannoniere_bloc.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:football_app/widgets/standingscorer.dart';
import 'package:football_app/widgets/standingscorer_head.dart';

class CapocannoniereScreen extends StatefulWidget {
  const CapocannoniereScreen({super.key});

  @override
  State<CapocannoniereScreen> createState() => _CapocannoniereScreenState();
}

class _CapocannoniereScreenState extends State<CapocannoniereScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CapocannoniereBloc(),
      child: BlocBuilder<CapocannoniereBloc, CapocannoniereState>(
        builder: (context, state) {
          if (state is CapocannoniereInitial) {
            context.read<CapocannoniereBloc>().add(CapocannoniereInit());
          }
          if (state is CapocannoniereReady) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "Classifica Marcatori",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(state.currentColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          StandingScorerHead(
                            currentColor: state.currentColor,
                            Logo: "assets/images/raimon.jpg",
                            Title: "Giocatore",
                            Winning: 'G',
                            Losing: 'A',
                            isFavorite: false,
                            position: 0,
                          ),
                          ...state.returned
                              .map(
                                (e) => StandingScorer(
                                  Logo: (e['logo'] == null)
                                      ? "assets/images/raimon.jpg"
                                      : e['logo'],
                                  currentColor: state.currentColor,
                                  Title: e["nominativo"].toString(),
                                  Winning: int.parse(e["gol"]),
                                  Losing: int.parse(e["assist"]),
                                  isFavorite: (e["OWNER"] == 0) ? false : true,
                                  position: e["POSITION"],
                                  idGiocatore: e['id_giocatore'],
                                ),
                              )
                              .toList(),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/raimon.jpg",
                          //   Title: "Raimon",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "30",
                          //   GolConcessed: "10",
                          //   Points: "30",
                          //   isFavorite: true,
                          //   position: 1,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/stoke.png",
                          //   Title: "Stoke City",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "27",
                          //   GolConcessed: "20",
                          //   Points: "26",
                          //   isFavorite: false,
                          //   position: 2,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/southampton.png",
                          //   Title: "Southhampton",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "20",
                          //   GolConcessed: "22",
                          //   Points: "18",
                          //   isFavorite: false,
                          //   position: 3,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/liverpool.png",
                          //   Title: "Liverpool",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "23",
                          //   GolConcessed: "27",
                          //   Points: "16",
                          //   isFavorite: false,
                          //   position: 4,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/FCBarcelona.png",
                          //   Title: "Barcelona",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "18",
                          //   GolConcessed: "24",
                          //   Points: "14",
                          //   isFavorite: false,
                          //   position: 4,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/west_ham.png",
                          //   Title: "West Ham",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "16",
                          //   GolConcessed: "22",
                          //   Points: "12",
                          //   isFavorite: false,
                          //   position: 4,
                          // ),
                          // Capocannoniere(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/swansea.png",
                          //   Title: "Swansea AFC",
                          //   Winning: 1,
                          //   Losing: 1,
                          //   GolScored: "17",
                          //   GolConcessed: "27",
                          //   Points: "10",
                          //   isFavorite: false,
                          //   position: 6,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is CapocannoniereLoading) {
            return const Loading(
              duration: Duration(seconds: 1),
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
