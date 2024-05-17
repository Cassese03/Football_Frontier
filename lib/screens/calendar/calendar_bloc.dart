import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:football_app/constants.dart';

import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarInit>(onInit);
  }
}

onInit(CalendarInit event, Emitter<CalendarState> emit) async {
  emit(CalendarLoading());

  int currentColor = kprimaryColor.value;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var check = prefs.getInt('primaryColor');

  if (check != null) {
    currentColor = check;
  } else {
    currentColor = kprimaryColor.value;
  }

  var access_token = prefs.getString('access_token');

  var response = await http.post(
    Uri.parse('http://ws.footballfrontier.it/api2/calendario'),
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

    return emit(CalendarReady(currentColor, returned));
  } else {
    return emit(CalendarInitial());
  }
}
