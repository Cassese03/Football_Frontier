import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import 'package:football_app/constants.dart';
import 'package:get/get.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

part 'referto_event.dart';

part 'referto_state.dart';

class RefertoBloc extends Bloc<RefertoEvent, RefertoState> {
  RefertoBloc() : super(RefertoInitial()) {
    on<RefertoInit>(onInit);

    on<RefertoSend>(onSend);
  }

  onSend(RefertoSend event, Emitter<RefertoState> emit) async {
    emit(RefertoLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentColor = kprimaryColor.value;

    var access_token = prefs.getString('access_token');

    var response = await http.post(
      Uri.parse('https://ws.footballfrontier.it/api2/sendReferto'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: json.encode(
        <String, dynamic>{
          'token': access_token.toString(),
          'result': jsonDecode(event.result),
          'idpartita': event.idPartita
        },
      ),
    );

    if (response.statusCode == 200) {
      var returned = json.decode(response.body);

      return emit(RefertoSuccess());
    } else {
      return emit(RefertoDenied());
    }
  }

  onInit(RefertoInit event, Emitter<RefertoState> emit) async {
    emit(RefertoLoading());

    int currentColor = kprimaryColor.value;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var check = prefs.getInt('primaryColor');

    if (check != null) {
      currentColor = check;
    } else {
      currentColor = kprimaryColor.value;
    }

    var access_token = prefs.getString('access_token');

    if (event.idPartita == 0) {
      var response = await http.post(
        Uri.parse('https://ws.footballfrontier.it/api2/calendario'),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          <String, String>{
            'token': access_token.toString(),
          },
        ),
      );

      if (response.statusCode == 200) {
        var returned = json.decode(response.body);

        return emit(RefertoReady(currentColor, returned));
      } else {
        return emit(RefertoDenied());
      }
    } else {
      var response = await http.post(
        Uri.parse('https://ws.footballfrontier.it/api2/referto'),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          <String, String>{
            'token': access_token.toString(),
            'idPartita': event.idPartita.toString(),
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, Map<String, int>> result = {};

        var returned = json.decode(response.body);

        for (var e in returned) {
          for (var e2 in e['squadra_casa']) {
            if (result['"${e2['id']}"'] == null) {
              result['"${e2['id']}"'] = {'"gol"': 0};
            } else if (result['"${e2['id']}"']?['"gol"'] == null) {
              result['"${e2['id']}"']?['"gol"'] = 0;
            }
          }
        }

        for (var e in returned) {
          for (var e2 in e['squadra_ospite']) {
            if (result['"${e2['id']}"'] == null) {
              result['"${e2['id']}"'] = {'"gol"': 0};
            } else if (result['"${e2['id']}"']?['"gol"'] == null) {
              result['"${e2['id']}"']?['"gol"'] = 0;
            }
          }
        }

        return emit(RefertoReadyReferto(currentColor, returned, result));
      } else {
        return emit(RefertoDenied());
      }
    }
  }
}
