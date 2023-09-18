import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/components/components.dart';
import 'package:task_management/cubit/login/login_states.dart';

import '../components/screen_size.dart';
import '../cubit/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
      LoginCubit cubit = LoginCubit.get(context);
      return Scaffold(
        body: Form(
          key: cubit.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight * 0.04,
                ),
                Text(
                  'Login to access your assigned tasks and personal overveiw',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight * 0.04,
                ),
                TextFieldComponent(
                  label: 'Email',
                  controller: cubit.loginEmailController,
                  picon: Icon(Icons.email_outlined),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                        .hasMatch(value);
                    if (value.isEmpty) {
                      return 'please enter your email';
                    } else if (!emailValid) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenSize.screenHeight * 0.02,
                ),
                TextFieldComponent(
                  label: 'Password',
                  controller: cubit.loginPasswordController,
                  isPassword: true,
                  picon: Icon(Icons.lock_outline_rounded),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenSize.screenHeight * 0.03,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: cubit.keepLogedInChecked,
                      onChanged: (bool? value) {
                        cubit.handleCheckboxChanged(value!);
                      },
                    ),
                    Text('Keep me logged in'),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.screenHeight * 0.03,
                ),
                defaultButton(
                    text: 'LOGIN',
                    onpressed: () {
                      print('object');
                      if (cubit.loginFormKey.currentState!.validate()) {
                        print('object2');
                        cubit.loginUser(context);
                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
