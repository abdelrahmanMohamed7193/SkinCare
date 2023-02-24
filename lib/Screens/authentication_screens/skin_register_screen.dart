import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/authentication_screens/skin_login_screen.dart';
import 'package:shoppingapp/cubit/register_cubit/skin_register_cubit.dart';
import 'package:shoppingapp/cubit/register_cubit/skin_register_states.dart';
import 'package:shoppingapp/shared/component.dart';

class SkinRegisterScreen extends StatelessWidget {
  SkinRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SkinRegisterCubit(),
      child: BlocConsumer<SkinRegisterCubit, SkinRegisterStates>(
          listener: (context, state) {
        if (state is SkinCreateUserSuccessState) {
          navigateAndFinish(context: context, widget: SkinLoginScreen());
          print('registered Successfully \nLogin Now');
          showToast(
            text: 'Successfully Registered \nLogin Now!!',
            state: ToastStates.WARNING,
          );
        }
        if (state is SkinRegisterErrorState) {
          print(" Register Errorrrrr   ${state.error.toString()}");
          showToast(
            text: state.error.message,
            state: ToastStates.ERROR,
          );
        }

        if (state is SkinCreateUserErrorState) {
          print(" Create User Error...   ${state.error.toString()}");
          showToast(
            text: state.error.message,
            state: ToastStates.ERROR,
          );
        }



      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Skin Application'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Register",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text("Register Now To Enjoy Our Services",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      myTextField(
                        //onSubmit: (){},
                        prefixIcon: Icons.person,
                        validateText: "Please Enter Your name",
                        controller: nameController,
                        label: " Name",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      myTextField(
                        //onSubmit: (){},
                        prefixIcon: Icons.email,
                        validateText: "Please Enter Your email",
                        controller: emailController,
                        label: "Email",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      myTextField(
                        prefixIcon: Icons.lock_clock_outlined,
                        suffixIcon: SkinRegisterCubit.get(context).suffix,
                        validateText: "Please Enter Your PassWord",
                        controller: passwordController,
                        label: " Password",
                        isPassword: SkinRegisterCubit.get(context).isPassword,
                        SuffixPressed: () {
                          SkinRegisterCubit.get(context)
                              .SkinChangPasswordVisibility();
                        },
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.visiblePassword,
                        //onSubmit: (){},
                      ),
                      myTextField(
                        prefixIcon: Icons.phone,
                        validateText: "Please Enter Your phone number",
                        controller: phoneController,
                        label: "phone",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.phone,
                        //   onSubmit: (){},
                      ),
                      ConditionalBuilder(
                        condition: state is! SkinRegisterLoadingState,
                        builder: (context) => myButton(
                            text: "Register",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                SkinRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
