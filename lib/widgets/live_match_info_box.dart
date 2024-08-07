import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';

class LiveMatchInfoBox extends StatelessWidget {
  final int awayGoal, homeGoal, completata, giornata;
  final String awayLogo, homeLogo, awayTitle, homeTitle;
  final List statistiche;
  const LiveMatchInfoBox({
    super.key,
    required this.awayGoal,
    required this.homeGoal,
    required this.completata,
    required this.awayLogo,
    required this.homeLogo,
    required this.awayTitle,
    required this.homeTitle,
    required this.statistiche,
    required this.giornata,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kboxColor,
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: AssetImage("assets/images/cl.png"),
          opacity: 0.2,
          alignment: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Bombonera",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  return (homeLogo == 'assets/images/raimon.jpg')
                      ? Column(
                          children: [
                            Image.asset(
                              homeLogo,
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              homeTitle,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Image(
                              width: 90,
                              height: 90,
                              image: NetworkImage(
                                homeLogo,
                              ),
                            ),
                            Text(
                              homeTitle,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                }),
              ),
              Builder(builder: (context) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFF4E5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: kprimaryColor,
                            size: 10,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            (completata == 0) ? "Live" : "Completata",
                            style: const TextStyle(
                              color: kprimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: homeGoal.toString(),
                            style: TextStyle(
                              fontSize: 36,
                              color: kprimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " : ${awayGoal.toString()}",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              Expanded(
                child: Builder(builder: (context) {
                  return (awayLogo == 'assets/images/raimon.jpg')
                      ? Column(
                          children: [
                            Image.asset(
                              awayLogo,
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              awayTitle,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Image(
                              width: 90,
                              height: 90,
                              image: NetworkImage(
                                awayLogo,
                              ),
                            ),
                            Text(
                              awayTitle,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: 3,
                  bottom: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "ST",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "FT",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                ...statistiche.map(
                  (e) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 40,
                          child: Text(
                            (e["casa"] == 1) ? e["nominativo"] : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        (e["gol"] == 1)
                            ? const Expanded(
                                flex: 20,
                                child: Icon(
                                  Icons.sports_soccer,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              )
                            : const Expanded(
                                flex: 20,
                                child: ImageIcon(
                                  AssetImage('assets/images/assist.png'),
                                  color: Colors.white,
                                ),
                              ),
                        Expanded(
                          flex: 40,
                          child: Text(
                            (e["ospite"] == 1) ? e["nominativo"] : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
