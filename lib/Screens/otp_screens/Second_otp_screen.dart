import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoppingapp/Screens/layout_screens/Skin_Layout.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_home.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_layout2.dart';
import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_states.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

class SecondOtpScreen extends StatelessWidget {
  SecondOtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;
  late String otpCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthStates>(
        listenWhen: (previous ,current){
          return previous!= current ;
        },
        listener: (context, state) {
          if (state is PhoneOtpVerifiedState) {
            navigateAndFinish(
              context: context,
              widget: SkinLayout2(),
            );
          }
          if (state is PhoneAuthErrorState) {
            print(state.error.toString()) ;
            showToast(
                text: state.error.toString(),
                state: ToastStates.ERROR ,
            );
          }

        },
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
                child: Column(
                  children: [
                    buildIntroText(),
                    SizedBox(
                      height: 88,
                    ),
                    buildCodePinFields(context),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ConditionalBuilder(
                            condition: state is! LoadingState,
                            builder: (context)=> myButton(
                                  text: 'Verify',
                                  onTap: () {
                                    PhoneAuthCubit.get(context).submitOtp(otpCode);
                                  },
                                ),
                            fallback: (context)=> const Center(child: CircularProgressIndicator() ,),
                        ) ,


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please Verify Your Phone Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: RichText(
            text: TextSpan(
                text: 'Enter Your 6 Digit Code Numbers Sent To You at ',
                style: TextStyle(
                  color: Colors.black,
                  height: 1.4,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${phoneNumber}',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  Widget buildCodePinFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        //obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: defaultColor,
          inactiveColor: defaultColor,
          activeFillColor: defaultColor,
          inactiveFillColor: Colors.white,
          selectedColor: Colors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        // errorAnimationController: errorController,
        // controller: textEditingController,
        onCompleted: (submittedCode) {
         otpCode =submittedCode  ;
          print("Completed OTP Submitted in pinFields UI ${otpCode}");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
