part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class MainLoading extends MainState {}

final class MainReady extends MainState {
  final int currentColor;

  MainReady(this.currentColor);
}
