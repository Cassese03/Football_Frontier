part of 'squad_bloc.dart';


@immutable

sealed class SquadState {}


final class SquadInitial extends SquadState {}


final class SquadReady extends SquadState {

  final int currentColor;


  final Map returned;


  SquadReady(this.currentColor, this.returned);

}


final class SquadLoading extends SquadState {}


final class SquadEditing extends SquadState {}


final class SquadEditingSuccess extends SquadState {

  final String esito;


  SquadEditingSuccess(this.esito);

}


final class SquadEditingFailed extends SquadState {

  final String error;


  SquadEditingFailed(this.error);

}

