import 'package:bloc/bloc.dart';


import 'package:football_app/constants.dart';


import 'package:meta/meta.dart';


import 'package:shared_preferences/shared_preferences.dart';


part 'standing_event.dart';


part 'standing_state.dart';


class StandingBloc extends Bloc<StandingEvent, StandingState> {

  StandingBloc() : super(StandingInitial()) {

    on<StandingInit>(onInit);

  }


  onInit(StandingInit event, Emitter<StandingState> emit) async {

    emit(StandingLoading());


    int currentColor = kprimaryColor.value;


    SharedPreferences prefs = await SharedPreferences.getInstance();


    var check = prefs.getInt('primaryColor');


    if (check != null) {

      currentColor = check;

    } else {

      currentColor = kprimaryColor.value;

    }


    emit(StandingReady(currentColor));

  }

}

