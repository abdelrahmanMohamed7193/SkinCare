import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/layout_screens/Skin_Layout.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_home.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_layout2.dart';
import 'package:shoppingapp/Screens/otp_screens/first_otp_screen.dart';
import 'package:shoppingapp/Screens/onboarding_screens/onBoardingScreen.dart';
import 'package:shoppingapp/Screens/authentication_screens/skin_login_screen.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_cubit.dart';
import 'package:shoppingapp/firebase_options.dart';
import 'package:shoppingapp/shared/bloc_observer.dart';
import 'package:shoppingapp/shared/styles/themes.dart';

import 'network/local/cash_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidProvider: AndroidProvider.debug,
  // );
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CashHelper.init();

  late Widget widget;

  bool? onBoarding = CashHelper.getData(key: "onBoarding");
  var uId = CashHelper.getData(key: 'uId') ?? null;
  var verificationId=CashHelper.getData(key: 'VerificationId') ?? null;
  print("verificationId From Main is ${verificationId}");

  if (onBoarding != null) {
    if (uId != null) {
      widget = SkinLayout2();
    } else {
      widget = SkinLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print("this bool for opening in login or onboard is $onBoarding ");

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkinCubit()..getUserData(),
      child: MaterialApp(
        theme: lightTheme,
        home: FirstOtpScreen(),
      ),
    );
  }
}
