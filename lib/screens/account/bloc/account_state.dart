part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInit extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountFetched extends AccountState {
  final Map returned;

  AccountFetched(this.returned);
}

final class AccountEditing extends AccountState {}

final class AccountEditingSuccess extends AccountState {
  final String esito;

  AccountEditingSuccess(this.esito);
}

final class AccountEditingFailed extends AccountState {
  final String error;

  AccountEditingFailed(this.error);
}
