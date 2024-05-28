part of 'referto_bloc.dart';

@immutable
sealed class RefertoEvent {}

final class RefertoInit extends RefertoEvent {
  int idPartita;

  RefertoInit({required this.idPartita});
}

final class RefertoSend extends RefertoEvent {
  String result;

  int idPartita;

  RefertoSend({required this.result, required this.idPartita});
}
