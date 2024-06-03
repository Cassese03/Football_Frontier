part of 'calendar_bloc.dart';


@immutable

sealed class CalendarState {}


final class CalendarInitial extends CalendarState {}


final class CalendarReady extends CalendarState {

  final int currentColor;

  final List returned;

  final List returned2;


  CalendarReady(this.currentColor, this.returned, this.returned2);

}


final class CalendarLoading extends CalendarState {}

