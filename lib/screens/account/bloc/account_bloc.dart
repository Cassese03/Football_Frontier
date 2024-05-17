import 'dart:async';

import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInit()) {
    on<AccountEdit>(onEdit);

    on<AccountTryEdit>(onTryEdit);

    on<AccountLoad>(onLoad);
  }

  FutureOr<void> onEdit(AccountEdit event, Emitter<AccountState> emit) async {
    emit(AccountEditing());
  }

  FutureOr<void> onTryEdit(
      AccountTryEdit event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    final response = await http.post(
      Uri.parse('http://ws.footballfrontier.it/api2/cambia_img_profilo'),
      body: {
        'token': access_token.toString(),
        'image': event.base64Image.toString()
      },
    );
    if (response.statusCode == 200) {
      emit(AccountEditingSuccess(response.body));
    } else {
      emit(AccountEditingFailed('ERRORE'));
    }
    //emit(AccountEditingFailed('ERRORE'));
  }

  FutureOr<void> onLoad(AccountLoad event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var access_token = prefs.getString('access_token');

    var response = await http.post(
      Uri.parse('http://ws.footballfrontier.it/api2/profilo'),
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
      return emit(AccountFetched(returned));
    } else {
      return emit(AccountInit());
    }
  }
}
