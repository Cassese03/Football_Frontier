import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/main/main_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class StandingScorer extends StatelessWidget {
  final String Logo, Title;
  final bool isFavorite;
  final int position, currentColor, Winning, Losing, idGiocatore;
  const StandingScorer({
    super.key,
    required this.Title,
    required this.currentColor,
    required this.Winning,
    required this.Losing,
    required this.isFavorite,
    required this.position,
    required this.idGiocatore,
    required this.Logo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            currentTab: 6,
            idGiocatore: idGiocatore,
          ),
        ),
      ),
      //Get.to(
      //  () => MainScreen(
      //    currentTab: 5,
      //    idSquadra: 0,
      //  ),
      //  transition: Transition.rightToLeft,
      //  duration: const Duration(seconds: 1),
      //),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kbackgroundColor,
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  position.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 65,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          if (Logo == 'assets/images/raimon.jpg')
                            Image.asset(
                              Logo,
                              height: 45,
                              width: 45,
                              fit: BoxFit.fill,
                            )
                          else
                            Image(
                              height: 45,
                              width: 45,
                              image: NetworkImage(Logo),
                              fit: BoxFit.fill,
                            ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              Title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
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
                  flex: 35,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            Winning.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            Losing.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Container(
          //     height: 115,
          //     width: 1.5,
          //     decoration: const BoxDecoration(
          //       color: Color(currentColor),
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30),
          //         topRight: Radius.circular(30),
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Container(
          //     height: 115,
          //     width: 1.5,
          //     decoration: const BoxDecoration(
          //       color: Color(currentColor),
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30),
          //         topRight: Radius.circular(30),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 5,
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    (position == 15) ? Color(currentColor) : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          isFavorite
              ? Positioned(
                  top: 20,
                  left: 5,
                  child: Icon(
                    Iconsax.star_1,
                    color: Color(currentColor),
                    size: 14,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
