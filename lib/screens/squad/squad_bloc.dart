import 'package:bloc/bloc.dart';


import 'package:football_app/constants.dart';


import 'package:meta/meta.dart';


import 'package:shared_preferences/shared_preferences.dart';


part 'squad_event.dart';


part 'squad_state.dart';


class SquadBloc extends Bloc<SquadEvent, SquadState> {

  SquadBloc() : super(SquadInitial()) {

    on<SquadInit>(onInit);

  }


  onInit(SquadInit event, Emitter<SquadState> emit) async {

    emit(SquadLoading());


    int currentColor = kprimaryColor.value;


    SharedPreferences prefs = await SharedPreferences.getInstance();


    var check = prefs.getInt('primaryColor');


    if (check != null) {

      currentColor = check;

    } else {

      currentColor = kprimaryColor.value;

    }


    emit(SquadReady(currentColor));

  }

}

