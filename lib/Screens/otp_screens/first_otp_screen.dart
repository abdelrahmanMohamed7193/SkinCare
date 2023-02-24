import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_home.dart';
import 'package:shoppingapp/Screens/otp_screens/Second_otp_screen.dart';
import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_states.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/constants.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

class FirstOtpScreen extends StatelessWidget {
  FirstOtpScreen({Key? key}) : super(key: key);

  late String phoneNumber;
  var phoneFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context,) =>
          PhoneAuthCubit(),
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthStates>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is PhoneAuthNumberSubmittedSuccessState)
          {
            navigateTo(context: context,
              widget: SecondOtpScreen(
                  phoneNumber: phoneNumber
              ),);
            // CashHelper.saveData(
            //   key: 'verificationId',
            //   value: state.verificationId,
            // ).then((value) {
            // //  print('verificationId From First OTP Listener is ${state.verificationId}');
            //   print('Number Submitted Then Now Otp coming Coming ');
            //   showToast(
            //     text: 'Number Submitted \nNow  OTP Coming',
            //     state: ToastStates.WARNING,
            //   );
            // //  PublicVerificationId = state.verificationId;
            //   navigateTo(
            //     context: context,
            //     widget: SecondOtpScreen(
            //       phoneNumber: phoneNumber,
            //     ),
            //   );
            // });

          }

          if (state is PhoneAuthErrorState) {
            showToast(
              text: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: phoneFormKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
                    child: Column(
                      children: [
                        buildIntroText1(),
                        SizedBox(
                          height: 88,
                        ),
                        buildPhoneFormField(),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ConditionalBuilder(
                              condition: state is! LoadingState,
                              builder: (context) =>
                                  myButton(
                                    text: 'Next',
                                    onTap: () {
                                      if (phoneFormKey.currentState!
                                          .validate()) {
                                        phoneFormKey.currentState!.save();
                                        PhoneAuthCubit.get(context).submitPhoneNumber(phoneNumber);
                                      }
                                    },
                                  ),
                              fallback: (context) =>
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildIntroText1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          'what is your phone number ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Text(
          'Please Enter your Phone Number To Verify Your Account ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget buildPhoneFormField() {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            generateCountryFlag() + "" + "+20",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 16.0,
      ),
      Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: TextFormField(
            autofocus: true,
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 2,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter your Phone Number';
              } else if (value.length < 11) {
                return 'Too Short For A phone Number!';
              }
              return null;
            },
            onSaved: (value) {
              phoneNumber = value!;
            },
          ),
        ),
      ),
    ]);
  }

  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(
      RegExp(
        r"[A-Z]",
      ),
          (match) =>
          String.fromCharCode(
            match.group(0)!.codeUnitAt(0) + 127397,
          ),
    );
    return flag;
  }
}
