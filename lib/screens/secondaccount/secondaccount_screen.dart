import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/constants.dart';
import 'package:badges/badges.dart' as badges;
import 'package:football_app/screens/account/bloc/account_bloc.dart';
import 'package:football_app/widgets/loading.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/stats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// ignore: must_be_immutable
class SecondAccountScreen extends StatefulWidget {
  int? idGiocatore;
  SecondAccountScreen({super.key, this.idGiocatore});
  @override
  State<SecondAccountScreen> createState() => _SecondAccountScreenState();
}

class _SecondAccountScreenState extends State<SecondAccountScreen> {
  int currentColor = kprimaryColor.value;
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getInt('primaryColor');
    if (check != null) {
      setState(() {
        currentColor = check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AccountBloc(),
        child: Builder(builder: (context) {
          return BlocConsumer<AccountBloc, AccountState>(
            listener: (BuildContext context, AccountState state) {
              if (state is AccountEditing) {
                TextEditingController nome = TextEditingController();
                TextEditingController cognome = TextEditingController();
                TextEditingController ruolo = TextEditingController();
                TextEditingController squadra = TextEditingController();
                showDialog<AccountTryEdit?>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Modifica Profilo',
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Inserisci Nome',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: nome,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Inserisci Cognome',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: cognome,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Inserisci Ruolo',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: ruolo,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Inserisci Squadra',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: squadra,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Modifica'),
                      )
                    ],
                  ),
                ).then(
                  (value) {
                    if (value == null) return;
                    context.read<AccountBloc>().add(value);
                  },
                );
              }
              if (state is AccountEditingFailed) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Text(
                      state.error,
                    ),
                  ),
                );
              }
              if (state is AccountEditingSuccess) {
                showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                    child: Text('Complimenti'),
                  ),
                );
              }
            },
            builder: (BuildContext context, AccountState state) {
              if (state is AccountLoading) {
                return const Loading(
                  duration: Duration(seconds: 1),
                );
              }
              if (state is AccountFetched) {
                return Fetched(context, state.returned);
              }
              if (state is AccountInit) {
                context.read<AccountBloc>().add(
                      AccountLoad(
                        (widget.idGiocatore != null) ? widget.idGiocatore! : 0,
                      ),
                    );
              }
              return const Loading(
                duration: Duration(seconds: 1),
              );
            },
          );
        }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container Fetched(BuildContext context, var returned) {
    return Container(
      color: kbackgroundColor,
      child: Column(
        children: [
          Expanded(
            flex: 30,
            child: Row(
              children: [
                const Spacer(),
                (returned["owner"] == true)
                    ? badges.Badge(
                        position: badges.BadgePosition.topEnd(),
                        badgeContent: const Icon(
                          Icons.edit,
                        ),
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: Colors.white,
                        ),
                        onTap: () async {
                          context.read<AccountBloc>().add(AccountEdit());
                        },
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Color(currentColor),
                            minRadius: 100,
                            child: (returned["profilo"][0]["img"] != null)
                                ? Image(
                                    image: MemoryImage(
                                      base64Decode(
                                        returned["profilo"][0]["img"],
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
                          backgroundColor: Color(currentColor),
                          minRadius: 100,
                          child: (returned["profilo"][0]["img"] != null)
                              ? Image(
                                  image: MemoryImage(
                                    base64Decode(
                                      returned["profilo"][0]["img"],
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
          Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        returned["profilo"][0]["nome"].toString(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 35,
            child: Column(
              children: [
                Expanded(
                  flex: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 50,
                        child: ProfileCard(
                          currentColor: currentColor,
                          numero: returned["statisticheSquadra"][0]
                              ["partitevinte"],
                          content: 'Partite Vinte',
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: ProfileCard(
                          currentColor: currentColor,
                          numero: returned["statisticheSquadra"][0]
                              ["partiteperse"],
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
                          currentColor: currentColor,
                          numero: returned["statisticheSquadra"][0]["presenze"],
                          content: 'Partite Giocate',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 5,
            child: Row(
              children: [
                Text(
                  "Statistiche Personali",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            flex: 50,
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/giocatore.png",
                  title: returned["profilo"][0]["nome"].toString(),
                  content:
                      "Posizione : ${returned["profilo"][0]["ruolo"].toString()}",
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/Gol.png",
                  title: "Gol",
                  content:
                      returned["statistichePersonali"][0]["gol"].toString(),
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/assist.png",
                  title: "Assist",
                  content:
                      returned["statistichePersonali"][0]["assist"].toString(),
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/maglia.png",
                  title: "Presenze",
                  content: returned["statistichePersonali"][0]["presenze"]
                      .toString(),
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/raimon.jpg",
                  title: "Squadra",
                  content: returned["profilo"][0]["nomesquadra"].toString(),
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
