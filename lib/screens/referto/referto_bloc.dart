import 'dart:convert';


import 'dart:math';


import 'package:bloc/bloc.dart';


import 'package:football_app/constants.dart';


import 'package:meta/meta.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;


part 'referto_event.dart';


part 'referto_state.dart';


class RefertoBloc extends Bloc<RefertoEvent, RefertoState> {

  RefertoBloc() : super(RefertoInitial()) {

    on<RefertoInit>(onInit);


    on<RefertoSend>(onSend);

  }


  onSend(RefertoSend event, Emitter<RefertoState> emit) async {

    emit(RefertoLoading());


    SharedPreferences prefs = await SharedPreferences.getInstance();


    int currentColor = kprimaryColor.value;


    var access_token = prefs.getString('access_token');


    var response = await http.post(

      Uri.parse('https://footballfrontier-be.vercel.app/api2/sendReferto'),

      headers: <String, String>{

        "Content-Type": "application/json",

      },

      body: jsonEncode(

        <String, String>{

          'token': access_token.toString(),

          'result': event.result.toString(),

        },

      ),

    );


    if (response.statusCode == 200) {

      var returned = json.decode(response.body);


      return emit(RefertoSuccess(returned));

    } else {

      return emit(RefertoDenied());

    }

  }


  onInit(RefertoInit event, Emitter<RefertoState> emit) async {

    emit(RefertoLoading());


    int currentColor = kprimaryColor.value;


    SharedPreferences prefs = await SharedPreferences.getInstance();


    var check = prefs.getInt('primaryColor');


    if (check != null) {

      currentColor = check;

    } else {

      currentColor = kprimaryColor.value;

    }


    var access_token = prefs.getString('access_token');


    if (event.idPartita == 0) {

      var response = await http.post(

        Uri.parse('https://footballfrontier-be.vercel.app/api2/calendario'),

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


        return emit(RefertoReady(currentColor, returned));

      } else {

        return emit(RefertoDenied());

      }

    } else {

      var response = await http.post(

        Uri.parse('https://footballfrontier-be.vercel.app/api2/referto'),

        headers: <String, String>{

          "Content-Type": "application/json",

        },

        body: jsonEncode(

          <String, String>{

            'token': access_token.toString(),

            'idPartita': event.idPartita.toString(),

          },

        ),

      );


      if (response.statusCode == 200) {

        var returned = json.decode(response.body);


        return emit(RefertoReadyReferto(currentColor, returned));

      } else {

        return emit(RefertoDenied());

      }

    }

  }

}

