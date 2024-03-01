import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/match_screen.dart';
import 'package:iconsax/iconsax.dart';

class UpComingLorenzo extends StatelessWidget {
  final String homeLogo, homeTitle, awayLogo, awayTitle, date, time;
  final bool isFavorite;
  const UpComingLorenzo({
    super.key,
    required this.homeLogo,
    required this.homeTitle,
    required this.awayLogo,
    required this.awayTitle,
    required this.date,
    required this.time,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MatchScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kbackgroundColor,
            ),
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 25,
                  child: Text(
                    homeTitle,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Image.asset(
                        homeLogo,
                        height: 45,
                        width: 45,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 20,
                  child: Column(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Image.asset(
                        awayLogo,
                        height: 45,
                        width: 45,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 25,
                  child: Text(
                    awayTitle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isFavorite ? kprimaryColor : Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        isFavorite
            ? const Positioned(
                top: 10,
                left: 10,
                child: Icon(
                  Iconsax.star5,
                  color: kprimaryColor,
                  size: 15,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
