part of 'match_bloc.dart';

@immutable
sealed class MatchState {}

final class MatchInitial extends MatchState {}

final class MatchReady extends MatchState {
  final int currentColor;

  final Map returned;

  MatchReady(this.currentColor, this.returned);
}

final class MatchLoading extends MatchState {}
