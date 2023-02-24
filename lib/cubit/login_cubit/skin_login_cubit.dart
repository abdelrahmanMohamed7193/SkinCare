
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/login_cubit/skin_login_states.dart';

class SkinLoginCubit extends Cubit<SkinLoginStates> {
  SkinLoginCubit() : super(SkinLoginInitialState());

  static SkinLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SkinLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email) ;
          print(value.user!.uid) ;
      emit(SkinLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SkinLoginErrorState(error)) ;
      print('Login Error ....    $error') ;
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void shopChangPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SkinChangPasswordVisibilityState());
  }
}
