import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_app/constants.dart';

class Notify extends StatelessWidget {
  final String Logo, Title, Content;
  final int Read;
  final int currentColor;
  const Notify({
    super.key,
    required this.Logo,
    required this.Title,
    required this.currentColor,
    required this.Content,
    required this.Read,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 10),
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
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  (Read == 0)
                      ? Icons.notifications_active
                      : Icons.notifications_active_outlined,
                ),
              ),
            ],
          ),
          Image.asset(
            Logo,
            height: 300,
            width: 300,
          ),
          Row(
            children: [
              const Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 90,
                child: Column(
                  children: [
                    Text(
                      Title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Content,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(currentColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
