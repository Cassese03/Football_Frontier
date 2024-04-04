part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeReady extends HomeState {
  final int currentColor;
  final Map returned;

  HomeReady(this.currentColor, this.returned);
}

final class HomeLoading extends HomeState {}
