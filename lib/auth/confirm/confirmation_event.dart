abstract class ConfirmationEvent{

}

class ConfirmationCodeChanged extends ConfirmationEvent{
  final String? code;

  ConfirmationCodeChanged({this.code});
}

// Going to take the event that will map to the state
class ConfirmationSubmitted extends ConfirmationEvent{}
