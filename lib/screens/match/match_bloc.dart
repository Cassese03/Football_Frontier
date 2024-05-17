import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:football_app/constants.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(MatchInitial()) {
    on<MatchInit>(onInit);
  }
}

onInit(MatchInit event, Emitter<MatchState> emit) async {
  emit(MatchLoading());

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
    Uri.parse('https://ws.footballfrontier.it/api2/statistiche_partita'),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(
      <String, String>{
        'token': access_token.toString(),
        'id_partita': event.idMatch.toString(),
      },
    ),
  );

  if (response.statusCode == 200) {
    var returned = json.decode(response.body);

    return emit(MatchReady(currentColor, returned));
  } else {
    return emit(MatchInitial());
  }
}
