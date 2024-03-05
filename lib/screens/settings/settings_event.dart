part of 'settings_bloc.dart';


@immutable

sealed class SettingsEvent {}


final class SettingsInit extends SettingsEvent {}


final class SettingsChangeColor extends SettingsEvent {}


final class SettingsColorChanged extends SettingsEvent {

  final int newColor;


  SettingsColorChanged({required this.newColor});

}

