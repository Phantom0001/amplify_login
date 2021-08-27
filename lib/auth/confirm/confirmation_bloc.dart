import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/auth/auth_repository.dart';

import '../auth_cubit.dart';
import '../form_submissions_status.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;

  ConfirmationBloc({this.authRepo, this.authCubit})
      : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // update username
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo?.confirmSignUp(
            username: authCubit?.credentials?.username,
            confirmationCode: state.code);
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit?.credentials;
        credentials?.userId = userId;
        authCubit?.launchSession(credentials!);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
