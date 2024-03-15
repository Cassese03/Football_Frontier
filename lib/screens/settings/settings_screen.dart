import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:football_app/common/appbarnotify.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/screens/settings/settings_bloc.dart';
import 'package:football_app/widgets/loading.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsTryChange) {
            Color value = kprimaryColor;
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Scegli il colore che preferisci'),
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
                      Navigator.pop(context);
                      context.read<SettingsBloc>().add(
                            SettingsColorChanged(newColor: value.value),
                          );
                    },
                  ),
                ],
              ),
            );
          }
          if (state is SettingsChanged) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Complimenti!'),
                content: const Text('Hai Cambiato Colore'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Ok',
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      context.read<SettingsBloc>().add(
                            SettingsInit(),
                          );
                    },
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SettingsInitial) {
            context.read<SettingsBloc>().add(SettingsInit());
          }
          if (state is SettingsReady) {
            return Scaffold(
              appBar: AppbarNotify(
                currentColor: state.currentColor,
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
                                  context
                                      .read<SettingsBloc>()
                                      .add(SettingsChangeColor());
                                },
                                icon: Icon(
                                  Icons.color_lens,
                                  color: Color(state.currentColor),
                                  size: 30.0,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                color: Color(state.currentColor),
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
          return const Loading(
            duration: Duration(seconds: 1),
          );
        },
      ),
    );
  }
}
