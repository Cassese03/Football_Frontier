part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class AccountEdit extends AccountEvent {}

final class AccountLoad extends AccountEvent {
  final int idGiocatore;

  AccountLoad(this.idGiocatore);
}

final class AccountTryEdit extends AccountEvent {
  final String Nome;

  final String Cognome;

  final String Ruolo;

  final String Squadra;

  AccountTryEdit(this.Nome, this.Cognome, this.Ruolo, this.Squadra);
}
