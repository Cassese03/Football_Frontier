import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

  if (event.username != 'pippo') {
    emit(LoginFailed('ERRORE USERNAME'));

    return;
  }

  if (event.password != 'pippo') {
    emit(LoginFailed('ERRORE PASSWORD'));

    return;
  }

  emit(LoginSuccess());
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

  if (remember! == true) {
    emit(LoginSuccess());

    Future.delayed(Duration(seconds: 2));

    return emit(LoginSuccess());
  }

  emit(LoginInit());
}
