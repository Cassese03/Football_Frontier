import 'package:bloc/bloc.dart';

import 'package:football_app/constants.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsInit>(onInit);

    on<SettingsColorChanged>(onColorChanged);

    on<SettingsChangeColor>((event, emit) => emit(SettingsTryChange()));
  }
}

onColorChanged(SettingsColorChanged event, Emitter<SettingsState> emit) async {
  emit(SettingsLoading());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setInt('primaryColor', event.newColor);

  emit(SettingsChanged());
}

onInit(SettingsInit event, Emitter<SettingsState> emit) async {
  emit(SettingsLoading());

  int currentColor = kprimaryColor.value;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var check = prefs.getInt('primaryColor');

  if (check != null) {
    currentColor = check;
  } else {
    currentColor = kprimaryColor.value;
  }

  emit(SettingsReady(currentColor));
}
