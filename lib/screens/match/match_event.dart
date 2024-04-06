part of 'match_bloc.dart';

@immutable
sealed class MatchEvent {}

final class MatchInit extends MatchEvent {
  final int idMatch;

  MatchInit(this.idMatch);
}

final class MatchEdit extends MatchEvent {}
