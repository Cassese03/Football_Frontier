import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInit()) {
    on<LoginCheckRemember>(onCheck);

    on<LoginOnTapLogin>(onLogin);

    on<LoginOnTapRemember>(onRemember);
  }
}

onLogin(LoginOnTapLogin event, Emitter<LoginState> emit) async {
  emit(LoginLoading());

  var response = await http.post(
    Uri.parse('https://footballfrontier-be.vercel.app/api2/login'),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(
      <String, String>{
        'email': event.username,
        'password': event.password,
      },
    ),
  );
  if (response.statusCode == 200) {
    var returned = json.decode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', returned["access_token"]);

    await prefs.setString('email', event.username);

    emit(LoginSuccess());
    return;
  } else {
    var returned = json.decode(response.body);

    return emit(LoginFailed(returned["error"]));
  }
}

onRemember(LoginOnTapRemember event, Emitter<LoginState> emit) async {
  emit(LoginLoading());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool('rememberMe', event.rememberMe);

  emit(LoginRemember(event.rememberMe));
}

onCheck(LoginCheckRemember event, Emitter<LoginState> emit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? remember = await prefs.getBool('rememberMe');

  if (remember
  ! == true) {
    emit(LoginLoading());

    var access_token = prefs.getString('access_token');

    var email = prefs.getString('email');

    var response = await http.post(
      Uri.parse('https://footballfrontier-be.vercel.app/api2/fast_login'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          'token': access_token.toString(),
          'email': email.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      var returned = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('access_token', returned["access_token"]);

      return emit(LoginSuccess());
    } else {
      prefs.setBool('rememberMe', false);
      return emit(LoginRemember(false));
    }
  }
  return emit(LoginRemember(remember));
}
