part of 'standing_bloc.dart';


@immutable

sealed class StandingState {}


final class StandingInitial extends StandingState {}


final class StandingReady extends StandingState {

  final int currentColor;


  StandingReady(this.currentColor);

}


final class StandingLoading extends StandingState {}

