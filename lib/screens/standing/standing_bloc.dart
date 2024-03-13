import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:football_app/constants.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

part 'standing_event.dart';

part 'standing_state.dart';

class StandingBloc extends Bloc<StandingEvent, StandingState> {
  StandingBloc() : super(StandingInitial()) {
    on<StandingInit>(onInit);
  }

  onInit(StandingInit event, Emitter<StandingState> emit) async {
    emit(StandingLoading());

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
      Uri.parse('https://footballfrontier-be.vercel.app/api2/classifica'),
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

      return emit(StandingReady(currentColor, returned));
    } else {
      return emit(StandingInitial());
    }
  }
}
