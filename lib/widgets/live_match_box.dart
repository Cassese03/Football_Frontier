import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/match/match_screen.dart';

class LiveMatchBox extends StatelessWidget {
  final String homeLogo, homeTitle, awayLogo, awayTitle;
  final int time, awayGoal, homeGoal, giornata, idPartita;
  final Color color, textColors;
  final DecorationImage backgroundImage;
  const LiveMatchBox({
    super.key,
    required this.homeLogo,
    required this.homeTitle,
    required this.awayLogo,
    required this.awayTitle,
    required this.idPartita,
    required this.time,
    required this.awayGoal,
    required this.giornata,
    required this.homeGoal,
    required this.color,
    required this.textColors,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchScreen(idPartita: idPartita),
          ),
        );
      },
      child: Container(
        height: 175,
        width: MediaQuery.of(context).size.width / 1.25,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          image: backgroundImage,
        ),
        child: Column(
          children: [
            Text(
              "Bombonera",
              style: TextStyle(
                color: textColors,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              (giornata != 8 && giornata != 9)
                  ? 'Giornata ${giornata.toString()}'
                  : (giornata == 8)
                      ? 'Semifinale Andata'
                      : 'Semifinale Ritorno',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Column(
                    children: [
                      (homeLogo == 'assets/images/raimon.jpg')
                          ? Image.asset(
                              homeLogo,
                              width: 75,
                              height: 75,
                            )
                          : Image(
                              width: 75,
                              height: 75,
                              image: NetworkImage(
                                homeLogo,
                              ),
                            ),
                      const SizedBox(height: 5),
                      Text(
                        homeTitle,
                        style: TextStyle(
                          color: textColors,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 40,
                  child: Column(
                    children: [
                      Text(
                        "$time'",
                        style: TextStyle(
                          color: textColors,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "$homeGoal : ",
                              style: TextStyle(
                                fontSize: 32,
                                color: textColors,
                              ),
                            ),
                            TextSpan(
                              text: "$awayGoal",
                              style: const TextStyle(
                                fontSize: 32,
                                color: kprimaryColor,
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
                  flex: 30,
                  child: Column(
                    children: [
                      (awayLogo == 'assets/images/raimon.jpg')
                          ? Image.asset(
                              awayLogo,
                              width: 75,
                              height: 75,
                            )
                          : Image(
                              width: 75,
                              height: 75,
                              image: NetworkImage(
                                awayLogo,
                              ),
                            ),
                      const SizedBox(height: 5),
                      Text(
                        awayTitle,
                        style: TextStyle(
                          color: textColors,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
