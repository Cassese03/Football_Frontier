import 'package:flutter/material.dart';
import 'package:football_app/common/appbar.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/standing.dart';
import 'package:football_app/widgets/standing_head.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StandingScreen extends StatefulWidget {
  const StandingScreen({super.key});

  @override
  State<StandingScreen> createState() => _StandingScreenState();
}

class _StandingScreenState extends State<StandingScreen> {
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
                    "Classifica",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(currentColor),
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
                  StandingHead(
                    currentColor: currentColor,
                    Logo: "assets/images/raimon.jpg",
                    Title: "Squadra",
                    Winning: 'W',
                    Losing: 'L',
                    GolScored: "GS",
                    GolConcessed: "GC",
                    Points: "P",
                    isFavorite: false,
                    position: 0,
                  ),
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
            )
          ],
        ),
      ),
    );
  }
}
