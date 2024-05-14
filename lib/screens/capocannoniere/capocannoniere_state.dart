part of 'capocannoniere_bloc.dart';

@immutable
sealed class CapocannoniereState {}

final class CapocannoniereInitial extends CapocannoniereState {}

final class CapocannoniereReady extends CapocannoniereState {
  final int currentColor;

  final List returned;

  CapocannoniereReady(this.currentColor, this.returned);
}

final class CapocannoniereLoading extends CapocannoniereState {}
