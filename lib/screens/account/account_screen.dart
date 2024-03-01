import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/common/appbar.dart';
import 'package:football_app/constants.dart';
import 'package:badges/badges.dart' as badges;
import 'package:football_app/screens/account/bloc/account_bloc.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
      appBar: AppbarAll(
        currentColor: currentColor,
      ),
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
                          Navigator.of(context).pop(
                            AccountTryEdit(
                              'prova',
                              'prova',
                              'prova',
                              'prova',
                            ),
                          );
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
                return const Center(child: CircularProgressIndicator());
              }
              return Fetched(context);
            },
          );
        }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container Fetched(BuildContext context) {
    return Container(
      color: kbackgroundColor,
      child: Column(
        children: [
          Expanded(
            flex: 30,
            child: Row(
              children: [
                const Spacer(),
                badges.Badge(
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
                      foregroundImage: AssetImage(
                        'assets/images/pl.png',
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        'Lorenzo Cassese',
                      ),
                      Spacer(),
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
                          numero: 2,
                          content: 'Partite Vinte',
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: ProfileCard(
                          currentColor: currentColor,
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
                          currentColor: currentColor,
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
                  logo: "assets/images/arsenal.png",
                  title: "Lorenzo Cassese",
                  content: "Posizione : Difensore",
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/swansea.png",
                  title: "Gol",
                  content: "2",
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/west_ham.png",
                  title: "Assist",
                  content: "4",
                  icon: Icon(
                    Icons.stars_outlined,
                    size: 28,
                    color: Color(currentColor),
                  ),
                ),
                Stats(
                  currentColor: currentColor,
                  logo: "assets/images/pl.png",
                  title: "Presenze",
                  content: "4",
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
                  content: "Raimon",
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
