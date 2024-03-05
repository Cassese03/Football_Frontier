import 'package:bloc/bloc.dart';


import 'package:football_app/constants.dart';


import 'package:meta/meta.dart';


import 'package:shared_preferences/shared_preferences.dart';


part 'calendar_event.dart';


part 'calendar_state.dart';


class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {

  CalendarBloc() : super(CalendarInitial()) {

    on<CalendarInit>(onInit);

  }

}


onInit(CalendarInit event, Emitter<CalendarState> emit) async {

  emit(CalendarLoading());


  int currentColor = kprimaryColor.value;


  SharedPreferences prefs = await SharedPreferences.getInstance();


  var check = prefs.getInt('primaryColor');


  if (check != null) {

    currentColor = check;

  } else {

    currentColor = kprimaryColor.value;

  }


  emit(CalendarReady(currentColor));

}

