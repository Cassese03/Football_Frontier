import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/squad/squad_bloc.dart';
import 'package:football_app/widgets/anteprima_profilo_header.dart';
import 'package:football_app/widgets/loading.dart';
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
    return WillPopScope(
      key: GlobalKey(),
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: BlocProvider(
        create: (context) => SquadBloc(),
        child: BlocBuilder<SquadBloc, SquadState>(
          builder: (context, state) {
            if (state is SquadInitial) {
              context.read<SquadBloc>().add(SquadInit(widget.squad));
            }
            if (state is SquadLoading) {
              return const Loading(
                duration: Duration(seconds: 1),
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
                                    numero: state.returned.entries
                                        .where(
                                            (entry) => entry.key == "squadra")
                                        .first
                                        .value[0]["partitevinte"],
                                    content: 'Partite Vinte',
                                  ),
                                ),
                                Expanded(
                                  flex: 50,
                                  child: ProfileCard(
                                    currentColor: state.currentColor,
                                    numero: state.returned.entries
                                        .where(
                                            (entry) => entry.key == "squadra")
                                        .first
                                        .value[0]["partiteperse"],
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
                                    numero: state.returned.entries
                                        .where(
                                            (entry) => entry.key == "squadra")
                                        .first
                                        .value[0]["presenze"],
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
                              Text(
                                state.returned.entries
                                    .where((entry) => entry.key == "squadra")
                                    .first
                                    .value[0]["nome"]
                                    .toString(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(state.currentColor),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AnteprimaProfiloHeader(
                                currentColor: state.currentColor,
                              ),
                              ...state.returned.entries
                                  .where((entry) => entry.key == "giocatori")
                                  .map(
                                (entry) {
                                  return Column(
                                    children: entry.value.map<Widget>(
                                      (giocatore) {
                                        return AnteprimaProfilo(
                                          currentColor: state.currentColor,
                                          Logo: "assets/images/raimon.jpg",
                                          Title: giocatore["nominativo"],
                                          Ruolo: giocatore["ruolo"],
                                          Gol: giocatore["gol"],
                                          Assits: giocatore["assist"],
                                          isFavorite: false,
                                          Presenze: giocatore["presenze"],
                                          idGiocatore:
                                              giocatore["id_giocatore"],
                                        );
                                      },
                                    ).toList(),
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
