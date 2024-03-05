part of 'settings_bloc.dart';


@immutable

sealed class SettingsState {}


final class SettingsInitial extends SettingsState {}


final class SettingsReady extends SettingsState {

  final int currentColor;


  SettingsReady(this.currentColor);

}


final class SettingsLoading extends SettingsState {}


final class SettingsChanged extends SettingsState {}


final class SettingsTryChange extends SettingsState {}

