import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/shared/component.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
 primarySwatch: buildMaterialColor(defaultColor),
  floatingActionButtonTheme:  const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed ,
    selectedItemColor:defaultColor ,
    unselectedItemColor: Colors.grey,
    elevation: 0,
    backgroundColor: Colors.white,

  ),

);

ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: Colors.black54 ,
  primarySwatch: Colors.deepOrange,
  appBarTheme:  AppBarTheme(
      titleSpacing: 20,
      iconTheme: const IconThemeData(
        color: Colors.white ,

      ) ,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:Brightness.light ,
       // statusBarColor: HexColor('333739'),
      ) ,
      //backgroundColor: HexColor('333739'),
      elevation: 20,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,

      )

  ),
  floatingActionButtonTheme:const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),

  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed ,
    selectedItemColor:Colors.deepOrange ,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: defaultColor ,

  ),

  textTheme: const TextTheme(
    bodyText1:TextStyle(
      fontSize: 18 ,
      fontWeight:FontWeight.w600  ,
      color: Colors.white ,
    )  ,
  ) ,
);
