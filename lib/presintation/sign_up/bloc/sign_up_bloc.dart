import 'package:credit_card_1/presintation/sign_up/bloc/sign_up_event.dart';
import 'package:credit_card_1/presintation/sign_up/bloc/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignUpBloc() : super(SignUpInitialState());

  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpWithEmailAndPasswordEvent) {
      yield SignUpLoadingState();

      try {

        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        yield SignUpSuccessState();
      } catch (e) {
        yield SignUpErrorState('Xatolik yuz berdi: $e');
      }
    }
  }
}