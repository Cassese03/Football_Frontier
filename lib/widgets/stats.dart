import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';

class Stats extends StatelessWidget {
  final String logo;
  final String title;
  final String content;
  final Icon icon;
  final int currentColor;
  const Stats({
    super.key,
    required this.logo,
    required this.title,
    required this.currentColor,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kbackgroundColor,
              border: Border.all(
                color: Color(currentColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 65,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            logo,
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              content,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(currentColor),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 35,
                  child: Row(
                    children: [
                      const Spacer(),
                      icon,
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
