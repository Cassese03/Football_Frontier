part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginCheckRemember extends LoginEvent {}

final class LoginOnTapLogin extends LoginEvent {
  final String username;

  final String password;

  LoginOnTapLogin(this.username, this.password);
}

final class LoginOnTapLoginWithout extends LoginEvent {
  final String username;

  final String token;

  LoginOnTapLoginWithout(this.username, this.token);
}

final class LoginOnTapRemember extends LoginEvent {
  final bool rememberMe;

  LoginOnTapRemember(this.rememberMe);
}
