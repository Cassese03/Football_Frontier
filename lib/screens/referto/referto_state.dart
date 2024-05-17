part of 'referto_bloc.dart';


@immutable

sealed class RefertoState {}


final class RefertoInitial extends RefertoState {}


final class RefertoReady extends RefertoState {

  final int currentColor;


  final List returned;


  RefertoReady(this.currentColor, this.returned);

}


final class RefertoReadyReferto extends RefertoState {

  final int currentColor;


  final List returned;


  RefertoReadyReferto(this.currentColor, this.returned);

}


final class RefertoLoading extends RefertoState {}


final class RefertoDenied extends RefertoState {}


final class RefertoSuccess extends RefertoState {

  final String returned;


  RefertoSuccess(this.returned);

}

