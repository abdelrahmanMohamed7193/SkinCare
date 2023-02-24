
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/models/skin_user_model.dart';

import 'skin_register_states.dart';

class SkinRegisterCubit extends Cubit<SkinRegisterStates> {
  SkinRegisterCubit() : super(SkinRegisterInitialState());

  static SkinRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SkinRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          
      print(value.user!.email);
      print(value.user!.uid);

      userCreate(
           name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid
      ) ;

     // emit(SkinCreateUserSuccessState(value.user!.uid) ,) ;
        }).catchError((error) {
      emit(SkinRegisterErrorState(error));
      print(error);
    });
  }


  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SkinUserModel model= SkinUserModel(
      name: name  ,
      email:email  ,
      phone: phone ,
      uId: uId ,
      isEmailVerified: false ,
    ) ;
    print('Now in creating User') ;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set( model.toMap())
        .then((value) {
        emit(SkinCreateUserSuccessState(uId)) ;
        print('User Created Successfully ,,,,');
    }).catchError((error){
      print(error);
      emit(SkinCreateUserErrorState(error)) ;
    });
  }



  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void SkinChangPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SkinRegisterChangPasswordVisibilityState());
  }
}
