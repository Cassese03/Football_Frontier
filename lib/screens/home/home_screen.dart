import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/widgets/live_match_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Live Match",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kbackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(blurRadius: 20, color: Colors.grey.shade200),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/pl.png",
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          "Premier League",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          CupertinoIcons.chevron_down,
                          size: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView(
                padding: const EdgeInsets.only(left: 20),
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                children: const [
                  LiveMatchBox(
                    awayGoal: 3,
                    homeGoal: 0,
                    time: 83,
                    awayLogo: "assets/images/leicester_city.png",
                    homeLogo: "assets/images/chelsea.png",
                    awayTitle: "Lester City",
                    homeTitle: "Chelsea",
                    color: kboxColor,
                    textColors: Colors.white,
                    backgroundImage: DecorationImage(
                      image: AssetImage("assets/images/pl.png"),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomLeft,
                      opacity: 0.3,
                    ),
                  ),
                  LiveMatchBox(
                    awayGoal: 3,
                    homeGoal: 0,
                    time: 65,
                    awayLogo: "assets/images/man_united.png",
                    homeLogo: "assets/images/west_ham.png",
                    awayTitle: "Man United",
                    homeTitle: "West Ham",
                    color: ksecondBoxColor,
                    textColors: Colors.black,
                    backgroundImage: DecorationImage(
                      image: AssetImage("assets/images/pl.png"),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomLeft,
                      opacity: 0.1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
