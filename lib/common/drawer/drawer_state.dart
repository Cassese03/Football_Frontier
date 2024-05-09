part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {}

final class DrawerLoading extends DrawerState {}

final class DrawerTapped extends DrawerState {
  final int currentTab;

  DrawerTapped(this.currentTab);
}

final class DrawerTappedSettings extends DrawerState {}

final class DrawerTappedRegolamento extends DrawerState {}

final class DrawerTappedLogout extends DrawerState {}
