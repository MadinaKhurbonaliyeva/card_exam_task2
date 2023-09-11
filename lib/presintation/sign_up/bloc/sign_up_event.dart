abstract class SignUpEvent {}

class SignUpWithEmailAndPasswordEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPasswordEvent(this.email, this.password);
}
