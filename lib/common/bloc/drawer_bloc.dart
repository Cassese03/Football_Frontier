import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<DrawerTapHome>(OnTappedHome);
    on<DrawerTapCalendar>(OnTappedCalendar);
    on<DrawerTapStanding>(OnTappedStanding);
    on<DrawerTapLineups>(OnTappedLineups);
    on<DrawerTapAccount>(OnTappedAccount);
    on<DrawerTapSettings>(OnTappedSettings);
    on<DrawerTapLogout>(OnTappedLogout);
  }
}

// ignore: non_constant_identifier_names
OnTappedHome(DrawerTapHome event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTapped(0));
}

OnTappedCalendar(DrawerTapCalendar event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTapped(1));
}

OnTappedStanding(DrawerTapStanding event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTapped(2));
}

OnTappedLineups(DrawerTapLineups event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTapped(3));
}

OnTappedAccount(DrawerTapAccount event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTapped(4));
}

OnTappedSettings(DrawerTapSettings event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  emit(DrawerTappedSettings());
}

OnTappedLogout(DrawerTapLogout event, Emitter<DrawerState> emit) async {
  emit(DrawerLoading());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool('rememberMe', false);

  emit(DrawerTappedLogout());
}
