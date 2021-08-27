import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/session_cubit.dart';

class SessionPage extends StatelessWidget {
  final String username;

  SessionPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello there, $username"),
            TextButton(
              child: Text('Sign Out'),
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
