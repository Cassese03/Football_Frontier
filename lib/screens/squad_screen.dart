import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/anteprima_profilo_header.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/anteprima_profilo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SquadScreen extends StatefulWidget {
  int squad;
  SquadScreen({super.key, required this.squad});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
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
                      backgroundColor: Color(currentColor),
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
                      currentColor: currentColor,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Lorenzo",
                      Ruolo: "Difensore",
                      Gol: 1,
                      Assits: 4,
                      isFavorite: true,
                      Presenze: 4,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Lorenzo",
                      Ruolo: "Difensore",
                      Gol: 1,
                      Assits: 4,
                      isFavorite: false,
                      Presenze: 4,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Lorenzo",
                      Ruolo: "Difensore",
                      Gol: 1,
                      Assits: 4,
                      isFavorite: false,
                      Presenze: 4,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Lorenzo",
                      Ruolo: "Difensore",
                      Gol: 1,
                      Assits: 4,
                      isFavorite: false,
                      Presenze: 4,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Lorenzo",
                      Ruolo: "Difensore",
                      Gol: 1,
                      Assits: 4,
                      isFavorite: false,
                      Presenze: 4,
                    ),
                    AnteprimaProfilo(
                      currentColor: currentColor,
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
}
