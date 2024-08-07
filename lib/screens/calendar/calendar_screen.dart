import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/screens/calendar/calendar_bloc.dart';
import 'package:football_app/widgets/giornata.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:football_app/widgets/upcoming_lorenzo.dart';
import 'package:football_app/widgets/upcoming_lorenzoCompletato.dart';
import 'package:intl/intl.dart' as inter;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarReady) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            "Calendario",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
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
                                      return UpComingLorenzo(
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
                          ...state.returned2.map(
                            (e) {
                              return Column(
                                children: [
                                  Giornata(
                                    currentColor: state.currentColor,
                                    giornata: e['giornata'],
                                  ),
                                  ...e['partite_concluse'].map(
                                    (e) {
                                      return UpComingLorenzoCompletato(
                                        idPartita: e['IdPartita'],
                                        homeLogo: (e['immaginecasa'] != null)
                                            ? e['immaginecasa']
                                            : "assets/images/raimon.jpg",
                                        homeTitle: e['nomecasa'],
                                        awayLogo: (e['immagineospite'] != null)
                                            ? e['immagineospite']
                                            : "assets/images/SoloMcDonald.png",
                                        awayTitle: e['nomeospite'],
                                        score: e['score'].toString(),
                                        isFavorite: false,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                          // const UpComingLorenzo(
                          //   awayLogo: "assets/images/man_united.png",
                          //   awayTitle: "Man United",
                          //   homeLogo: "assets/images/liverpool.png",
                          //   homeTitle: "Liverpool FC",
                          //   date: "30 Dec",
                          //   time: "06:30",
                          //   isFavorite: true,
                          // ),
                          // const UpComingLorenzo(
                          //   awayLogo: "assets/images/swansea.png",
                          //   awayTitle: "Swansea AFC",
                          //   homeLogo: "assets/images/tottenham.png",
                          //   homeTitle: "Tottenham",
                          //   date: "30 Dec",
                          //   time: "06:30",
                          //   isFavorite: false,
                          // ),
                          // const UpComingLorenzo(
                          //   awayLogo: "assets/images/stoke.png",
                          //   awayTitle: "Stoke City",
                          //   homeLogo: "assets/images/arsenal.png",
                          //   homeTitle: "Arsenal",
                          //   date: "30 Dec",
                          //   time: "06:30",
                          //   isFavorite: false,
                          // ),
                          // const UpComingLorenzo(
                          //   awayLogo: "assets/images/southampton.png",
                          //   awayTitle: "Southhampton",
                          //   homeLogo: "assets/images/sunderland.png",
                          //   homeTitle: "Sunderland",
                          //   date: "30 Dec",
                          //   time: "06:30",
                          //   isFavorite: false,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is CalendarInitial) {
            context.read<CalendarBloc>().add(CalendarInit());
          }
          if (state is CalendarLoading) {
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
