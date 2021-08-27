abstract class SignUpEvent{

}

class SignUpUsernameChanged extends SignUpEvent{
  final String? username; // Holds on the username that is always changing

  SignUpUsernameChanged({this.username});
}

class SignUpEmailChanged extends SignUpEvent{
  final String? email; // Holds on the username that is always changing

  SignUpEmailChanged({this.email});
}


class SignUpPasswordChanged extends SignUpEvent{
  final String? password; // Holds on the password that is always changing

  SignUpPasswordChanged({this.password});

}

// Going to take the event that will map to the state
class SignUpSubmitted extends SignUpEvent{}
