import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/session_cubit.dart';
import 'package:login_app/session_page.dart';
import 'package:login_app/session_state.dart';

import 'auth/auth_cubit.dart';
import 'auth/auth_navigator.dart';
import 'loading_page.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show the loading page
          if (state is UnknownSessionState) MaterialPage(child: LoadingPage()),

          // show the authentication flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),

          // Show the session view
          if(state is Authenticated) MaterialPage(child: SessionPage()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
