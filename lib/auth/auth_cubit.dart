import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_cubit.dart';
import 'auth_credentials.dart';

enum AuthState { login, signUp, confirmSignUp }

// Reponsible for switching signup to login, as well as hanging on to username
class AuthCubit extends Cubit<AuthState> {
  final SessionCubit? sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);

  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) => sessionCubit?.showSession(credentials);
}
