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
    emit(AccountLoading());

    emit(AccountEditing());
  }

  FutureOr<void> onTryEdit(
      AccountTryEdit event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    if (1 == 1) emit(AccountEditingFailed('ERRORE'));

    if (1 == 2) emit(AccountEditingSuccess('Fatto'));
  }

  FutureOr<void> onLoad(AccountLoad event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

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
      return emit(AccountFetched(returned));
    } else {
      return emit(AccountInit());
    }
  }
}
