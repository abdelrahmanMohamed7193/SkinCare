
abstract class SkinRegisterStates{}
class SkinRegisterInitialState extends SkinRegisterStates{}

class SkinRegisterLoadingState extends SkinRegisterStates{}
class SkinRegisterSuccessState extends SkinRegisterStates
{

}
class SkinRegisterErrorState extends SkinRegisterStates{
  final dynamic error ;

  SkinRegisterErrorState(this.error);

}

class SkinCreateUserSuccessState extends SkinRegisterStates
{
final String uId ;

  SkinCreateUserSuccessState(this.uId);
}
class SkinCreateUserErrorState extends SkinRegisterStates{
  final dynamic error ;

  SkinCreateUserErrorState(this.error);

}

class SkinRegisterChangPasswordVisibilityState extends SkinRegisterStates{}
