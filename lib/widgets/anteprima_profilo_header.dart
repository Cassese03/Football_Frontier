import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';

class AnteprimaProfiloHeader extends StatelessWidget {
  final int currentColor;
  const AnteprimaProfiloHeader({
    super.key,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      const Column(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            'Nome Cognome',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ruolo',
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
                            'Presenze',
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
                            'Gol',
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
                            'Assits',
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
        ],
      ),
    );
  }
}
