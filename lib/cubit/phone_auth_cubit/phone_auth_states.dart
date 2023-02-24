abstract class PhoneAuthStates{}

class PhoneAuthInitialState extends PhoneAuthStates{}

class LoadingState extends PhoneAuthStates{}
class PhoneAuthErrorState extends PhoneAuthStates{
  final String error ;

  PhoneAuthErrorState(this.error);
}


class PhoneAuthNumberSubmittedSuccessState extends PhoneAuthStates{

}
class PhoneOtpVerifiedState extends PhoneAuthStates{}
