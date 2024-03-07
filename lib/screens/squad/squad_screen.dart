import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/squad/squad_bloc.dart';
import 'package:football_app/widgets/anteprima_profilo_header.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/anteprima_profilo.dart';

// ignore: must_be_immutable
class SquadScreen extends StatefulWidget {
  int squad;
  SquadScreen({super.key, required this.squad});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SquadBloc(),
      child: BlocBuilder<SquadBloc, SquadState>(
        builder: (context, state) {
          if (state is SquadInitial) {
            context.read<SquadBloc>().add(SquadInit());
          }
          if (state is SquadLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SquadReady) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const Spacer(),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Color(state.currentColor),
                              minRadius: 100,
                              foregroundImage: const AssetImage(
                                'assets/images/raimon.jpg',
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: ProfileCard(
                                  currentColor: state.currentColor,
                                  numero: 2,
                                  content: 'Partite Vinte',
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: ProfileCard(
                                  currentColor: state.currentColor,
                                  numero: 1,
                                  content: 'Partite Perse',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: ProfileCard(
                                  currentColor: state.currentColor,
                                  numero: 3,
                                  content: 'Partite Giocate',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            AnteprimaProfiloHeader(
                              currentColor: state.currentColor,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: true,
                              Presenze: 4,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: false,
                              Presenze: 4,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: false,
                              Presenze: 4,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: false,
                              Presenze: 4,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: false,
                              Presenze: 4,
                            ),
                            AnteprimaProfilo(
                              currentColor: state.currentColor,
                              Logo: "assets/images/raimon.jpg",
                              Title: "Lorenzo",
                              Ruolo: "Difensore",
                              Gol: 1,
                              Assits: 4,
                              isFavorite: false,
                              Presenze: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
