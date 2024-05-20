import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:football_app/screens/referto/referto_bloc.dart';
import 'package:football_app/widgets/giornata.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:football_app/widgets/upcoming_lorenzoreferto.dart';
import 'package:intl/intl.dart' as inter;

// ignore: must_be_immutable
class RefertoScreen extends StatefulWidget {
  int? idPartita;
  RefertoScreen({super.key, this.idPartita});

  @override
  State<RefertoScreen> createState() => _RefertoScreenState();
}

class _RefertoScreenState extends State<RefertoScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> result = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RefertoBloc(),
      child: BlocBuilder<RefertoBloc, RefertoState>(
        builder: (context, state) {
          if (state is RefertoInitial) {
            context.read<RefertoBloc>().add(
                  RefertoInit(
                    idPartita:
                        (widget.idPartita != null) ? widget.idPartita! : 0,
                  ),
                );
          }
          if (state is RefertoReady) {
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
                            "Scegli Partita",
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
                          ...state.returned.map(
                            (e) {
                              return Column(
                                children: [
                                  Giornata(
                                    currentColor: state.currentColor,
                                    giornata: e['giornata'],
                                  ),
                                  ...e['partite'].map(
                                    (e) {
                                      String datamatch = e['datamatch'];
                                      DateTime dateTime =
                                          DateTime.parse(datamatch);
                                      String dataFormattata =
                                          '${dateTime.day} ${inter.DateFormat('LLLL', 'it').format(DateTime(2024, dateTime.month))}';
                                      String orarioFormattato =
                                          '${dateTime.hour}:${(dateTime.minute < 10) ? '0${dateTime.minute}' : dateTime.minute}';
                                      return UpComingLorenzoReferto(
                                        idPartita: e['IdPartita'],
                                        homeLogo: (e['immaginecasa'] != null)
                                            ? e['immaginecasa']
                                            : "assets/images/raimon.jpg",
                                        homeTitle: e['nomecasa'],
                                        awayLogo: (e['immagineospite'] != null)
                                            ? e['immagineospite']
                                            : "assets/images/SoloMcDonald.png",
                                        awayTitle: e['nomeospite'],
                                        date: orarioFormattato,
                                        time: dataFormattata,
                                        isFavorite: false,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                          // StandingScorerHead(
                          //   currentColor: state.currentColor,
                          //   Logo: "assets/images/raimon.jpg",
                          //   Title: "Giocatore",
                          //   Winning: 'G',
                          //   Losing: 'A',
                          //   isFavorite: false,
                          //   position: 0,
                          // ),
                          // ...state.returned
                          //     .map(
                          //       (e) => StandingScorer(
                          //         currentColor: state.currentColor,
                          //         Title: e["nominativo"].toString(),
                          //         Winning: int.parse(e["gol"]),
                          //         Losing: int.parse(e["assist"]),
                          //         isFavorite: (e["OWNER"] == 0) ? false : true,
                          //         position: e["POSITION"],
                          //         idGiocatore: e['id_giocatore'],
                          //       ),
                          //     )
                          //     .toList(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is RefertoDenied) {
            return AlertDialog(
              title: const Text('Impossibile Creare un Referto'),
              content: const Text(
                  'Ci dispiace non sei un organizzatore e quindi non puoi inserire questi dati.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(currentTab: 0),
                      ),
                    );
                  },
                  child: const Text('Torna alla Home Page'),
                ),
              ],
            );
          }
          if (state is RefertoLoading) {
            const Loading(
              duration: Duration(seconds: 1),
            );
          }
          if (state is RefertoSuccess) {
            return AlertDialog(
              title: const Text('Complimenti hai creato un Referto'),
              content: const Text('Adesso tornerai alla Home Page'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(currentTab: 0),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          }
          if (state is RefertoReadyReferto) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                bottomNavigationBar: FloatingActionButton(
                  onPressed: () {
                    context.read<RefertoBloc>().add(
                          RefertoSend(
                            result: result.toString(),
                          ),
                        );
                  },
                  child: Icon(Icons.send),
                ),
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text:
                            'Squadra Casa (${state.returned[0]['nome_casa'].toString()})',
                      ),
                      Tab(
                        text:
                            'Squadra Ospite (${state.returned[0]['nome_ospite'].toString()})',
                      ),
                    ],
                  ),
                  title: Text(
                      'Referto ${state.returned[0]['nome_casa'].toString()} - ${state.returned[0]['nome_ospite'].toString()}  '),
                ),
                body: TabBarView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...state.returned.map(
                            (e) {
                              return Column(
                                children: [
                                  ...e['squadra_casa'].map(
                                    (e2) {
                                      if (result['gol${e2['id']}'].toString() ==
                                          '') {
                                        result['gol${e2['id']}'] =
                                            'insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},0,0);';
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 65,
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/raimon.jpg",
                                                        height: 45,
                                                        width: 45,
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          e2['nominativo'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .grey.shade700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Expanded(
                                              flex: 35,
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'GOL',
                                                          ),
                                                          onChanged: (value) {
                                                            if (value == '') {
                                                              String stringhe =
                                                                  '';
                                                              for (int i = 0;
                                                                  i <
                                                                      int.parse(
                                                                          value
                                                                              .toString());
                                                                  i++) {
                                                                stringhe =
                                                                    '$stringhe insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},1,0);';
                                                              }
                                                              result['gol${e2['id']}'] =
                                                                  stringhe
                                                                      .toString();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'ASSIST',
                                                          ),
                                                          onChanged: (value) {
                                                            if (value == '') {
                                                              String stringhe =
                                                                  '';
                                                              for (int i = 0;
                                                                  i <
                                                                      int.parse(
                                                                          value
                                                                              .toString());
                                                                  i++) {
                                                                stringhe =
                                                                    '$stringhe insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},0,1);';
                                                              }
                                                              result['assist${e2['id']}'] =
                                                                  stringhe;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   'ASSIST',
                                                      //   style: const TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontSize: 18,
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...state.returned.map((e) {
                          return Column(
                            children: [
                              ...e['squadra_ospite'].map(
                                (e2) {
                                  if (result['gol${e2['id']}'].toString() ==
                                      '') {
                                    result['gol${e2['id']}'] =
                                        'insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},0,0);';
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 65,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/raimon.jpg",
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      e2['nominativo'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 35,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'GOL',
                                                      ),
                                                      onChanged: (value) {
                                                        if (value == '') {
                                                          String stringhe = '';
                                                          for (int i = 0;
                                                              i <
                                                                  int.parse(value
                                                                      .toString());
                                                              i++) {
                                                            stringhe =
                                                                '$stringhe insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},1,0);';
                                                          }
                                                          result['gol${e2['id']}'] =
                                                              stringhe;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'ASSIST',
                                                      ),
                                                      onChanged: (value) {
                                                        if (value != '') {
                                                          String stringhe = '';
                                                          for (int i = 0;
                                                              i <
                                                                  int.parse(value
                                                                      .toString());
                                                              i++) {
                                                            stringhe =
                                                                '$stringhe insert into statistiche_partite (id_giocatore,id_squadra,id_partita,gol,assist) values  (${e2['id']},${e2['id_squadra']},${e['id']},0,1);';
                                                          }
                                                          result['assist${e2['id']}'] =
                                                              stringhe;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
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
