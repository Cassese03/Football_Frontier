part of 'referto_bloc.dart';

@immutable
sealed class RefertoEvent {}

// ignore: must_be_immutable
final class RefertoInit extends RefertoEvent {
  int idPartita;

  RefertoInit({required this.idPartita});
}

// ignore: must_be_immutable
final class RefertoSend extends RefertoEvent {
  String result;

  int idPartita;

  RefertoSend({required this.result, required this.idPartita});
}
