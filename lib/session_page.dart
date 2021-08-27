import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/session_cubit.dart';

class SessionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Session Page"),
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
