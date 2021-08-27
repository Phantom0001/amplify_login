abstract class LoginEvent{

}

class LoginUsernameChanged extends LoginEvent{
  final String? username; // Holds on the username that is always changing

  LoginUsernameChanged({this.username});
}


class LoginPasswordChanged extends LoginEvent{
  final String? password; // Holds on the password that is always changing

  LoginPasswordChanged({this.password});

}

// Going to take the event that will map to the state
class LoginSubmitted extends LoginEvent{}
