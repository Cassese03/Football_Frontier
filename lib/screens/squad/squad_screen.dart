import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/squad/squad_bloc.dart';
import 'package:football_app/widgets/anteprima_profilo_header.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/anteprima_profilo.dart';
import 'package:badges/badges.dart' as badges;
import 'package:image_picker_web/image_picker_web.dart';

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
        child: BlocConsumer<SquadBloc, SquadState>(
          listener: (context, state) {
            if (state is SquadEditing) {
              showDialog<SquadTryEdit?>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Modifica Foto Squadra',
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final pickedFile =
                                await ImagePickerWeb.getImageAsBytes();
                            if (pickedFile != null) {
                              final base64String = base64Encode(pickedFile);
                              Navigator.of(context).pop(
                                SquadTryEdit(
                                  base64String,
                                ),
                              );
                            }
                          },
                          child: const Text('Scegli Immagine'),
                        ),
                      ],
                    ),
                  ),
                  actions: [],
                ),
              ).then(
                (value) {
                  if (value == null) return;
                  context.read<SquadBloc>().add(value);
                },
              );
            }

            if (state is SquadEditingFailed) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(state.error),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              ).then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SquadScreen(squad: widget.squad),
                  ),
                ),
              );
            }
            if (state is SquadEditingSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text(
                    'Complimenti hai aggiornato la tua immagine di squadra.',
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              ).then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SquadScreen(squad: widget.squad),
                  ),
                ),
              );
            }
          },
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
              print(state.returned["squadra"].toString());
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
                            (state.returned.entries
                                        .where(
                                            (entry) => entry.key == "capitano")
                                        .first
                                        .value ==
                                    1)
                                ? badges.Badge(
                                    position: badges.BadgePosition.topEnd(),
                                    badgeContent: const Icon(
                                      Icons.edit,
                                    ),
                                    badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.white,
                                    ),
                                    onTap: () async {
                                      context
                                          .read<SquadBloc>()
                                          .add(SquadEdit());
                                    },
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color(state.currentColor),
                                        minRadius: 100,
                                        child: (state.returned["squadra"][0]
                                                    ["img"] !=
                                                null)
                                            ? (state.returned["squadra"][0]
                                                        ["img"]
                                                    .toString()
                                                    .startsWith('https'))
                                                ? Image.network(
                                                    state.returned["squadra"][0]
                                                        ["img"],
                                                  )
                                                : Image(
                                                    image: MemoryImage(
                                                      base64Decode(
                                                        state.returned[
                                                                "squadra"][0]
                                                            ["img"],
                                                      ),
                                                    ),
                                                  )
                                            : Image.asset(
                                                'assets/images/pl.png',
                                              ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color(state.currentColor),
                                      minRadius: 100,
                                      child: (state.returned["squadra"][0]
                                                  ["img"] !=
                                              null)
                                          ? (state.returned["squadra"][0]["img"]
                                                  .toString()
                                                  .startsWith('https'))
                                              ? Image.network(
                                                  state.returned["squadra"][0]
                                                      ["img"],
                                                )
                                              : Image(
                                                  image: MemoryImage(
                                                    base64Decode(
                                                      state.returned["squadra"]
                                                          [0]["img"],
                                                    ),
                                                  ),
                                                )
                                          : Image.asset(
                                              'assets/images/pl.png',
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
                                          Title: giocatore["nominativo"]
                                              .toString(),
                                          Ruolo: giocatore["ruolo"],
                                          Gol: int.parse(giocatore["gol"]),
                                          Assits:
                                              int.parse(giocatore["assist"]),
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
