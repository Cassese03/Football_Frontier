part of 'squad_bloc.dart';


@immutable

sealed class SquadState {}


final class SquadInitial extends SquadState {}


final class SquadReady extends SquadState {

  final int currentColor;


  SquadReady(this.currentColor);

}


final class SquadLoading extends SquadState {}

