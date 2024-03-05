part of 'login_bloc.dart';


@immutable

sealed class LoginState {}


final class LoginInit extends LoginState {}


final class LoginCheckRememberState extends LoginState {}


final class LoginLoading extends LoginState {}


final class LoginRemember extends LoginState {

  final bool rememberMe;


  LoginRemember(this.rememberMe);

}


final class LoginFailed extends LoginState {

  final String error;


  LoginFailed(this.error);

}


final class LoginSuccess extends LoginState {}

