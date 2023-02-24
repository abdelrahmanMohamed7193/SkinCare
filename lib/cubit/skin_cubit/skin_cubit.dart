
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/layout_screens/any_tHing_screen.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_home.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_layout2.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_settings_screen.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_states.dart';
import 'package:shoppingapp/models/skin_user_model.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';

class SkinCubit extends Cubit<SkinStates>{
  SkinCubit() : super(SkinInitialState()) ;

  static SkinCubit get(context) =>BlocProvider.of(context) ;



  late SkinUserModel model ;
  void getUserData()
  {

    emit(SkinGetUserLoadingState()) ;

   var uId =CashHelper.getData(key:'uId' ) ;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){

  print(' value.data is  ${value.data()}' ) ;

      model =SkinUserModel.fromJson(value.data()!) ;
         emit(SkinGetUserSuccessState()) ;

    })
        .catchError((error){
          print(error.toString()) ;
emit(SkinGetUserErrorStates(error))  ;
    }) ;
  }
//////////////////////////////
  int currentIndex = 0  ;
  List<Widget> screens =
  [
    SkinHome() ,
    AnyTHingScreen(),
    SkinSettingsScreen() ,


  ] ;

  List<String> titles =
  [
    'Home' ,
    'Anything',
    'Settings' ,
  ] ;

  void changeBottomNav(int index)
  {
      currentIndex =index ;
      emit(SkinChangeBottomNavState()) ;
  }


}
