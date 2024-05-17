import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;

import 'package:football_app/constants.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'squad_event.dart';

part 'squad_state.dart';

class SquadBloc extends Bloc<SquadEvent, SquadState> {
  SquadBloc() : super(SquadInitial()) {
    on<SquadInit>(onInit);

    on<SquadEdit>(onEdit);

    on<SquadTryEdit>(onTryEdit);
  }

  onInit(SquadInit event, Emitter<SquadState> emit) async {
    emit(SquadLoading());

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
      Uri.parse('https://ws.footballfrontier.it/api2/dettaglio_squadra'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          'token': access_token.toString(),
          'id_squadra': event.idSquadra.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      var returned = json.decode(response.body);

      return emit(SquadReady(currentColor, returned));
    } else {
      return emit(SquadInitial());
    }
  }
}

void onEdit(SquadEdit event, Emitter<SquadState> emit) async {
  emit(SquadEditing());
}

void onTryEdit(SquadTryEdit event, Emitter<SquadState> emit) async {
  emit(SquadLoading());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var access_token = prefs.getString('access_token');

  final response = await http.post(
    Uri.parse('https://ws.footballfrontier.it/api2/cambia_img_squadra'),
    body: {
      'token': access_token.toString(),
      'image': event.base64Image.toString()
    },
  );

  if (response.statusCode == 200) {
    print(response.body);

    emit(SquadEditingSuccess(response.body));
  } else {
    print(response.body);

    emit(SquadEditingFailed('ERRORE'));
  }

  //emit(SquadEditingFailed('ERRORE'));
}
