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

