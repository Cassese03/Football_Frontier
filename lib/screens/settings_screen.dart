import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:football_app/common/appbarnotify.dart';
import 'package:football_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    log(check.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarNotify(
        currentColor: currentColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    children: [
                      const Spacer(),
                      const Text(
                        'Cambia Colore Principale',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          Color value = kprimaryColor;
                          return showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title:
                                  const Text('Scegli il colore che preferisci'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: kprimaryColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      value = color;
                                    });
                                  },
                                  pickerAreaHeightPercent: 0.8,
                                  paletteType: PaletteType.hsv,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Salva',
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt(
                                      'primaryColor',
                                      value.value,
                                    );
                                    setState(() {
                                      currentColor = value.value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.color_lens,
                          color: Color(currentColor),
                          size: 30.0,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        color: Color(currentColor),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
