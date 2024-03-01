import 'package:flutter/material.dart';
import 'package:football_app/common/appbar.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/giornata.dart';
import 'package:football_app/widgets/upcoming_lorenzo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int currentColor = kprimaryColor.value;
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getInt('primaryColor');
    if (check != null) {
      setState(() {
        currentColor = check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarAll(
        currentColor: currentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Calendario",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Giornata(currentColor: currentColor),
                  const UpComingLorenzo(
                    awayLogo: "assets/images/man_united.png",
                    awayTitle: "Man United",
                    homeLogo: "assets/images/liverpool.png",
                    homeTitle: "Liverpool FC",
                    date: "30 Dec",
                    time: "06:30",
                    isFavorite: true,
                  ),
                  const UpComingLorenzo(
                    awayLogo: "assets/images/swansea.png",
                    awayTitle: "Swansea AFC",
                    homeLogo: "assets/images/tottenham.png",
                    homeTitle: "Tottenham",
                    date: "30 Dec",
                    time: "06:30",
                    isFavorite: false,
                  ),
                  const UpComingLorenzo(
                    awayLogo: "assets/images/stoke.png",
                    awayTitle: "Stoke City",
                    homeLogo: "assets/images/arsenal.png",
                    homeTitle: "Arsenal",
                    date: "30 Dec",
                    time: "06:30",
                    isFavorite: false,
                  ),
                  const UpComingLorenzo(
                    awayLogo: "assets/images/southampton.png",
                    awayTitle: "Southhampton",
                    homeLogo: "assets/images/sunderland.png",
                    homeTitle: "Sunderland",
                    date: "30 Dec",
                    time: "06:30",
                    isFavorite: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
