part of 'squad_bloc.dart';


@immutable

sealed class SquadEvent {}


final class SquadInit extends SquadEvent {

  final int idSquadra;


  SquadInit(this.idSquadra);

}


final class SquadEdit extends SquadEvent {}


final class SquadTryEdit extends SquadEvent {

  final String base64Image;


  SquadTryEdit(this.base64Image);

}

