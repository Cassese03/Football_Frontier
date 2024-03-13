part of 'calendar_bloc.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitial extends CalendarState {}

final class CalendarReady extends CalendarState {
  final int currentColor;
  final List returned;

  CalendarReady(this.currentColor, this.returned);
}

final class CalendarLoading extends CalendarState {}
