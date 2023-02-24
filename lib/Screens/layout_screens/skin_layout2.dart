import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_cubit.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_states.dart';

class SkinLayout2 extends StatelessWidget {
  const SkinLayout2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkinCubit(),
      child: BlocConsumer<SkinCubit, SkinStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SkinCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.face,
                    ),
                    label: 'AnyThing',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
