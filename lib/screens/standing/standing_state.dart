part of 'standing_bloc.dart';


@immutable

sealed class StandingState {}


final class StandingInitial extends StandingState {}


final class StandingReady extends StandingState {

  final int currentColor;


  final List returned;


  StandingReady(this.currentColor, this.returned);

}


final class StandingLoading extends StandingState {}

