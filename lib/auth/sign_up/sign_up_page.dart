import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/auth/sign_up/sign_up_bloc.dart';
import 'package:login_app/auth/sign_up/sign_up_event.dart';
import 'package:login_app/auth/sign_up/sign_up_state.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submissions_status.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _signUpForm(),
            _showLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
      final formStatus = state.formStatus;
      if (formStatus is SubmissionFailed) {
        _showSnackBar(context, formStatus.exception.toString());
      }
    },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userNameField(),
              _emailField(),
              _passwordField(),
              SizedBox(
                height: 8.0,
              ),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userNameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) =>
        state.isValidUsername ? null : 'Username is too short!',
        onChanged: (value) => context.read<SignUpBloc>().add(
          SignUpUsernameChanged(username: value),
        ),
      );
    });
  }


  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          obscureText: false,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'Email',
          ),
          validator: (value) =>
          state.isValidEmail ? null : 'Email is invalid!',
          onChanged: (value) => context.read<SignUpBloc>().add(
            SignUpEmailChanged(email: value),
          ));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.security),
            hintText: 'Password',
          ),
          validator: (value) =>
          state.isValidPassword ? null : 'Password is too short!',
          onChanged: (value) => context.read<SignUpBloc>().add(
            SignUpPasswordChanged(password: value),
          ));
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<SignUpBloc>().add(SignUpSubmitted());
          }
        },
        child: Text("Sign up"),
      );
    });
  }

  Widget _showLoginButton(BuildContext context){
    return SafeArea(
      child: TextButton(
        onPressed: () => context.read<AuthCubit>().showLogin(),
        child: Text("Already have an account? Login now!"),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
