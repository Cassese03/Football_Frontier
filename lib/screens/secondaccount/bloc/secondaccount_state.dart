part of 'secondaccount_bloc.dart';

sealed class SecondAccountState {}

final class SecondAccountInit extends SecondAccountState {}

final class SecondAccountLoading extends SecondAccountState {}

final class SecondAccountFetched extends SecondAccountState {
  final Map returned;

  SecondAccountFetched(this.returned);
}

final class SecondAccountEditing extends SecondAccountState {}

final class SecondAccountEditingSuccess extends SecondAccountState {
  final String esito;

  SecondAccountEditingSuccess(this.esito);
}

final class SecondAccountEditingFailed extends SecondAccountState {
  final String error;

  SecondAccountEditingFailed(this.error);
}
