part of 'squad_bloc.dart';


@immutable

sealed class SquadEvent {}


final class SquadInit extends SquadEvent {

  final int idSquadra;


  SquadInit(this.idSquadra);

}

