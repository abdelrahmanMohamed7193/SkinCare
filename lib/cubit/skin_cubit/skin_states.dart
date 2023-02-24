abstract class SkinStates{}

class SkinInitialState extends SkinStates{}

class SkinGetUserLoadingState extends SkinStates{}
class SkinGetUserSuccessState extends SkinStates{
  // final String uId ;
  //
  // SkinGetUserSuccessState(this.uId);
}
class SkinGetUserErrorStates extends SkinStates{
  final dynamic error ;

  SkinGetUserErrorStates(this.error);
}

class SkinChangeBottomNavState extends SkinStates{}

