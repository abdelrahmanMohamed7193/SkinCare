
abstract class SkinLoginStates{}
class SkinLoginInitialState extends SkinLoginStates{}

class SkinLoginLoadingState extends SkinLoginStates{}
class SkinLoginSuccessState extends SkinLoginStates
{
final String uId ;

  SkinLoginSuccessState(this.uId);
}
class SkinLoginErrorState extends SkinLoginStates{
  final dynamic error ;

  SkinLoginErrorState(this.error);

}

class SkinChangPasswordVisibilityState extends SkinLoginStates{}
