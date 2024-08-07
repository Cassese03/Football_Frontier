import 'package:bloc/bloc.dart';

import 'package:football_app/constants.dart';

import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationInit>(onInit);
  }
}

onInit(NotificationInit event, Emitter<NotificationState> emit) async {
  emit(NotificationLoading());

  int currentColor = kprimaryColor.value;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var check = prefs.getInt('primaryColor');

  if (check != null) {
    currentColor = check;
  } else {
    currentColor = kprimaryColor.value;
  }

  emit(NotificationReady(currentColor));
}
