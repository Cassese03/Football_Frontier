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
      child: SingleChildScrollView(
        child: Container(
          height: 250,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            image: backgroundImage,
          ),
          child: Column(
            children: [
              Text(
                "Palladoro",
                style: TextStyle(
                  color: textColors,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Giornata $giornata",
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      (homeLogo == 'assets/images/raimon.jpg')
                          ? Image.asset(
                              homeLogo,
                              width: 90,
                              height: 90,
                            )
                          : Image(
                              width: 90,
                              height: 90,
                              image: MemoryImage(
                                base64Decode(
                                  homeLogo,
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        homeTitle,
                        style: TextStyle(
                          color: textColors,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 14,
                          color: textColors,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
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
                                fontSize: 36,
                                color: textColors,
                              ),
                            ),
                            TextSpan(
                              text: "$awayGoal",
                              style: const TextStyle(
                                fontSize: 36,
                                color: kprimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      (awayLogo == 'assets/images/raimon.jpg')
                          ? Image.asset(
                              awayLogo,
                              width: 90,
                              height: 90,
                            )
                          : Image(
                              width: 90,
                              height: 90,
                              image: MemoryImage(
                                base64Decode(
                                  awayLogo,
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        awayTitle,
                        style: TextStyle(
                          color: textColors,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Away",
                        style: TextStyle(
                          fontSize: 14,
                          color: textColors,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
