import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/referto/referto_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UpComingLorenzoReferto extends StatelessWidget {
  final String homeLogo, homeTitle, awayLogo, awayTitle, date, time;
  final int idPartita;
  final bool isFavorite;
  const UpComingLorenzoReferto({
    super.key,
    required this.homeLogo,
    required this.homeTitle,
    required this.awayLogo,
    required this.idPartita,
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
                builder: (context) => RefertoScreen(
                  idPartita: idPartita,
                ),
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
                      if (homeLogo == 'assets/images/raimon.jpg')
                        Image.asset(
                          homeLogo,
                          height: 45,
                          width: 45,
                        )
                      else
                        Image(
                          height: 45,
                          width: 45,
                          image: NetworkImage(homeLogo),
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
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        textAlign: TextAlign.center,
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
                      if (awayLogo == 'assets/images/SoloMcDonald.png')
                        Image.asset(
                          awayLogo,
                          height: 45,
                          width: 45,
                        )
                      else
                        Image(
                          height: 45,
                          width: 45,
                          image: NetworkImage(awayLogo),
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
                  Iconsax.star_1,
                  color: kprimaryColor,
                  size: 15,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
