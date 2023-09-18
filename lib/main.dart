
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/department_screens/create_department_screen.dart';
import 'package:task_management/screens/home_screens/choices.dart';
import 'package:task_management/screens/home_screens/home_screen.dart';
import 'package:task_management/screens/login_screen.dart';
import 'package:task_management/screens/user_screens/user_tasks.dart';

import 'constants/bloc_observer.dart';
import 'cubit/department/department_cubit.dart';
import 'cubit/home/home_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/task/task_cubit.dart';
import 'cubit/user/user_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => DepartmentCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            //theme: context.watch<ThemeCubit>().getThemeData(),
            //ThemeData.light(),
          );
        },
      ),
    );
  }
}

