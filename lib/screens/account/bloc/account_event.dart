part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class AccountEdit extends AccountEvent {}

final class AccountLoad extends AccountEvent {
  final int idGiocatore;

  AccountLoad(this.idGiocatore);
}

final class AccountTryEdit extends AccountEvent {
  final String base64Image;

  AccountTryEdit(this.base64Image);
}
