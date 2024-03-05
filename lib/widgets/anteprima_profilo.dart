import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/main_screen.dart';
import 'package:iconsax/iconsax.dart';

class AnteprimaProfilo extends StatelessWidget {
  final String Logo, Title, Ruolo;
  final bool isFavorite;
  final int currentColor;
  final int Presenze;
  final int Gol;
  final int Assits;
  const AnteprimaProfilo({
    super.key,
    required this.Logo,
    required this.Title,
    required this.Ruolo,
    required this.currentColor,
    required this.Presenze,
    required this.Gol,
    required this.isFavorite,
    required this.Assits,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            currentTab: 4,
            idGiocatore: 0,
          ),
        ),
      ),
      // Get.to(
      //   () => MainScreen(
      //     currentTab: 4,
      //     idGiocatore: 0,
      //   ),
      //   transition: Transition.rightToLeft,
      //   duration: const Duration(seconds: 1),
      // ),
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
                Expanded(
                  flex: 65,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            Logo,
                            height: 45,
                            width: 45,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            Title,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ruolo $Ruolo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(currentColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
                            Presenze.toString(),
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
                            Gol.toString(),
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
                            Assits.toString(),
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
                color: Colors.transparent,
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
                    Iconsax.star5,
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
