import 'dart:convert';


import 'package:bloc/bloc.dart';


import 'package:football_app/constants.dart';


import 'package:meta/meta.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;


part 'capocannoniere_event.dart';


part 'capocannoniere_state.dart';


class CapocannoniereBloc

    extends Bloc<CapocannoniereEvent, CapocannoniereState> {

  CapocannoniereBloc() : super(CapocannoniereInitial()) {

    on<CapocannoniereInit>(onInit);

  }


  onInit(CapocannoniereInit event, Emitter<CapocannoniereState> emit) async {

    emit(CapocannoniereLoading());


    int currentColor = kprimaryColor.value;


    SharedPreferences prefs = await SharedPreferences.getInstance();


    var check = prefs.getInt('primaryColor');


    if (check != null) {

      currentColor = check;

    } else {

      currentColor = kprimaryColor.value;

    }


    var access_token = prefs.getString('access_token');


    var response = await http.post(

      Uri.parse(

          'https://footballfrontier-be.vercel.app/api2/classifica_marcatori'),

      headers: <String, String>{

        "Content-Type": "application/json",

      },

      body: jsonEncode(

        <String, String>{

          'token': access_token.toString(),

        },

      ),

    );


    if (response.statusCode == 200) {

      var returned = json.decode(response.body);


      return emit(CapocannoniereReady(currentColor, returned));

    } else {

      return emit(CapocannoniereInitial());

    }

  }

}

