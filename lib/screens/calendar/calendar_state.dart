part of 'calendar_bloc.dart';


@immutable

sealed class CalendarState {}


final class CalendarInitial extends CalendarState {}


final class CalendarReady extends CalendarState {

  final int currentColor;


  CalendarReady(this.currentColor);

}


final class CalendarLoading extends CalendarState {}

