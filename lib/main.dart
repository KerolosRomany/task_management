
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/login_screen.dart';

import 'cubit/login/login_cubit.dart';

void main() async {
  // Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
            //theme: context.watch<ThemeCubit>().getThemeData(),
            //ThemeData.light(),
          );
        },
      ),
    );
  }
}

