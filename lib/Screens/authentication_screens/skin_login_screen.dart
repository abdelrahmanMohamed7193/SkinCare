

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/layout_screens/Skin_Layout.dart';
import 'package:shoppingapp/Screens/authentication_screens/skin_register_screen.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_home.dart';
import 'package:shoppingapp/Screens/layout_screens/skin_layout2.dart';
import 'package:shoppingapp/cubit/login_cubit/skin_login_cubit.dart';
import 'package:shoppingapp/cubit/login_cubit/skin_login_states.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/constants.dart';

class SkinLoginScreen extends StatelessWidget {
  SkinLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => SkinLoginCubit(),
      child: BlocConsumer<SkinLoginCubit, SkinLoginStates>(
        listener: (context, state) {
          if (state is SkinLoginErrorState) {
            print('login Errorrrr ${state.error.message}') ;
            showToast(text: state.error.message, state: ToastStates.ERROR);
          }

          if (state is SkinLoginSuccessState) {
            CashHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              print('Login Successfully')  ;
              showToast(text:'Logged In Successfully' , state: ToastStates.SUCCESS);
              uId =state.uId ;
              navigateAndFinish(context: context, widget: SkinLayout2()) ;
          });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("LOGIN",
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text("Login Now To Communicate with friends ",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        myTextField(
                          //onSubmit: () {},
                          prefixIcon: Icons.email,
                          validateText: "Please Enter Your Email Address",
                          controller: emailController,
                          label: " Email Address",
                          onChanged: () {},
                          onTap: () {},
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        myTextField(
                          prefixIcon: Icons.lock_clock_outlined,
                          suffixIcon: SkinLoginCubit.get(context).suffix,
                          validateText: "Please Enter Your PassWord",
                          controller: passwordController,
                          label: " Password",
                          isPassword: SkinLoginCubit.get(context).isPassword,
                          SuffixPressed: () {
                            SkinLoginCubit.get(context)
                                .shopChangPasswordVisibility();
                          },
                          onChanged: () {},
                          onTap: () {},
                          type: TextInputType.visiblePassword,
                         // onSubmit: () {},
                        ),
                        ConditionalBuilder(
                          condition: state is! SkinLoginLoadingState,
                          builder: (context) => myButton(
                              text: "LOGIN",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  SkinLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have An Account?"),
                            myDefaultTextButton(
                                function: () {
                                  navigateTo(
                                    context: context,
                                    widget: SkinRegisterScreen(),
                                  );
                                },
                                text: "Register Now"),
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
}
