import 'package:flutter/material.dart';
import 'package:football_app/common/appbar.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/profile_card.dart';
import 'package:football_app/widgets/standing.dart';
import 'package:football_app/widgets/standing_head.dart';
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
      appBar: AppbarAll(
        currentColor: currentColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 25,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Spacer(),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Color(currentColor),
                      minRadius: 100,
                      foregroundImage: const AssetImage(
                        'assets/images/raimon.jpg',
                      ),
                    ),
                  ),
                  Spacer(),
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
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/raimon.jpg",
                      Title: "Raimon",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "30",
                      GolConcessed: "10",
                      Points: "30",
                      isFavorite: true,
                      position: 1,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/stoke.png",
                      Title: "Stoke City",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "27",
                      GolConcessed: "20",
                      Points: "26",
                      isFavorite: false,
                      position: 2,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/southampton.png",
                      Title: "Southhampton",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "20",
                      GolConcessed: "22",
                      Points: "18",
                      isFavorite: false,
                      position: 3,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/liverpool.png",
                      Title: "Liverpool",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "23",
                      GolConcessed: "27",
                      Points: "16",
                      isFavorite: false,
                      position: 4,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/FCBarcelona.png",
                      Title: "Barcelona",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "18",
                      GolConcessed: "24",
                      Points: "14",
                      isFavorite: false,
                      position: 4,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/west_ham.png",
                      Title: "West Ham",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "16",
                      GolConcessed: "22",
                      Points: "12",
                      isFavorite: false,
                      position: 4,
                    ),
                    Standing(
                      currentColor: currentColor,
                      Logo: "assets/images/swansea.png",
                      Title: "Swansea AFC",
                      Winning: 1,
                      Losing: 1,
                      GolScored: "17",
                      GolConcessed: "27",
                      Points: "10",
                      isFavorite: false,
                      position: 6,
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
