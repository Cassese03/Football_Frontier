part of 'secondaccount_bloc.dart';

sealed class SecondAccountEvent {}

final class SecondAccountEdit extends SecondAccountEvent {}

final class SecondAccountLoad extends SecondAccountEvent {
  final int idGiocatore;

  SecondAccountLoad(this.idGiocatore);
}

final class SecondAccountTryEdit extends SecondAccountEvent {
  final String Nome;

  final String Cognome;

  final String Ruolo;

  final String Squadra;

  SecondAccountTryEdit(this.Nome, this.Cognome, this.Ruolo, this.Squadra);
}
