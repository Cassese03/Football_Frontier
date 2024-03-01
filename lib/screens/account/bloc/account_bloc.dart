import 'dart:async';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


part 'account_event.dart';


part 'account_state.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {

  AccountBloc() : super(AccountFetched()) {

    on<AccountEdit>(onEdit);


    on<AccountTryEdit>(onTryEdit);

  }


  FutureOr<void> onEdit(AccountEdit event, Emitter<AccountState> emit) async {

    emit(AccountLoading());


    emit(AccountEditing());

  }


  FutureOr<void> onTryEdit(

      AccountTryEdit event, Emitter<AccountState> emit) async {

    emit(AccountLoading());


    if (1 == 1) emit(AccountEditingFailed('ERRORE'));


    if (1 == 2) emit(AccountEditingSuccess('Fatto'));

  }

}

