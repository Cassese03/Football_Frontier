import 'dart:async';

import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

part 'secondaccount_event.dart';

part 'secondaccount_state.dart';

class SecondAccountBloc extends Bloc<SecondAccountEvent, SecondAccountState> {
  SecondAccountBloc() : super(SecondAccountInit()) {
    on<SecondAccountEdit>(onEdit);

    on<SecondAccountTryEdit>(onTryEdit);

    on<SecondAccountLoad>(onLoad);
  }

  FutureOr<void> onEdit(
      SecondAccountEdit event, Emitter<SecondAccountState> emit) async {
    emit(SecondAccountLoading());

    emit(SecondAccountEditing());
  }

  FutureOr<void> onTryEdit(
      SecondAccountTryEdit event, Emitter<SecondAccountState> emit) async {
    emit(SecondAccountLoading());

    if (1 == 1) emit(SecondAccountEditingFailed('ERRORE'));

    if (1 == 2) emit(SecondAccountEditingSuccess('Fatto'));
  }

  FutureOr<void> onLoad(
      SecondAccountLoad event, Emitter<SecondAccountState> emit) async {
    emit(SecondAccountLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var access_token = prefs.getString('access_token');

    var response = await http.post(
      Uri.parse('https://footballfrontier-be.vercel.app/api2/profilo'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          'token': access_token.toString(),
          'id': event.idGiocatore.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      var returned = json.decode(response.body);
      print(returned);
      return emit(SecondAccountFetched(returned));
    } else {
      return emit(SecondAccountInit());
    }
  }
}
