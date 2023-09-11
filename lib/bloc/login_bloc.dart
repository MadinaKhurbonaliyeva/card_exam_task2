// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../server/net.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is CheckUserEvent) {
        print("Apiga jonatildi");
        String? result = await login(event.email, event.password);
        if (result != null) {
          emit(CheckUserResult(response: result));
        } else {
          emit(CheckUserResult(
              response: "Ok ")); // Handle the case where login returns null
        }
      }
    });
  }
}
