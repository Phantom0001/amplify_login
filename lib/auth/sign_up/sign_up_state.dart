import 'package:login_app/auth/form_submissions_status.dart';

class SignUpState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus? formStatus;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  // constructor
  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }){
    return SignUpState(
      username: username ?? this.username,
      email: email?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );

  }


}