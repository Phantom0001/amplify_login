import 'package:login_app/auth/form_submissions_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus? formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  // constructor
  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }){
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );

  }


}
