import 'package:flutter/material.dart';
import 'package:football_app/constants.dart';
import 'package:football_app/constants/text_styles.dart';
import 'package:football_app/providers/players_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mailot.dart';

// ignore: must_be_immutable
class Player extends StatefulWidget {
  Offset coordinates;

  Player({required this.coordinates});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final GlobalKey _key = GlobalKey();
  double top = 0.0, left = 0.0;
  double xOff = 0.0, yOff = 0.0;

  String nome = 'Player';
  int currentColor = kprimaryColor.value;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    top = widget.coordinates.dy;
    left = widget.coordinates.dx;
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
  void dispose() {
    super.dispose();
  }

  void _getRenderOffsets() {
    final RenderBox renderBoxWidget =
        _key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBoxWidget.localToGlobal(Offset.zero);
    yOff = offset.dy - top;
    xOff = offset.dx - left;
  }

  void _afterLayout(_) {
    _getRenderOffsets();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: _key,
      top: top,
      left: left,
      height: 400,
      width: 400,
      child: Draggable(
        feedback: _playerSpot(),
        childWhenDragging: Container(),
        onDraggableCanceled: (_, drag) {
          return;
          // setState(
          //   () {
          //     top = drag.dy - yOff;
          //     left = drag.dx - xOff;
          //     log('left = $left');
          //     log('top = $top');
          //     widget.coordinates = Offset(left, top);
          //   },
          // );
        },
        child: _playerSpot(),
      ),
    );
  }

  Widget _playerSpot() => Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (builder) {
              TextEditingController nome = TextEditingController();
              return AlertDialog(
                actions: [
                  TextField(
                    controller: nome,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, nome.text);
                    },
                    child: const Text('Salva'),
                  ),
                ],
                title: const Text('Inserire Nome Giocatore'),
              );
            },
          ).then(
            (value) {
              setState(() {
                nome = value;
              });
            },
          ),
          child: Column(
            children: [
              Consumer<PlayersProvider>(
                builder: (__, provider, _) => CustomPaint(
                  size: Size(45, (45 * 1.0680100755667505).toDouble()),
                  painter: PlayerMailot(color: Color(currentColor)),
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: _playerName(),
              ),
            ],
          ),
        ),
      );

  Widget _playerName() => Text(
        nome,
        textAlign: TextAlign.center,
        style: playerName(),
      );
}
