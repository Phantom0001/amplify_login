import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/auth/auth_credentials.dart';
import 'package:login_app/auth/auth_repository.dart';

import '../auth_cubit.dart';
import '../form_submissions_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;

  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // update username
    if(event is LoginUsernameChanged){
      yield state.copyWith(username: event.username);
    }
    else if(event is LoginPasswordChanged){
      yield state.copyWith(password: event.password);
    }
    else if(event is LoginSubmitted){
      yield state.copyWith(formStatus: FormSubmitting());

      try{
        await authRepo?.login(username: state.username, password: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit?.launchSession(AuthCredentials(username: state.username));
      }catch(e){
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}