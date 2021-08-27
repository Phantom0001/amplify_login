import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/auth/sign_up/sign_up_page.dart';

import 'auth_cubit.dart';
import 'confirm/confirmation_page.dart';
import 'login/login_page.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Shows the login page
          if (state == AuthState.login) MaterialPage(child: LoginPage()),

          // Allows push to a new page
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            // Shows the sign up page
            MaterialPage(child: SignUpPage()),

            // Shows the confirm page
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationPage()),
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
