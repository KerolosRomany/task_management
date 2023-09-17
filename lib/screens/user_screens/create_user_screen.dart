import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/cubit/department/department_cubit.dart';
import 'package:task_management/cubit/department/department_states.dart';
import 'package:task_management/cubit/user/user_cubit.dart';
import 'package:task_management/cubit/user/user_cubit.dart';
import 'package:task_management/cubit/user/user_cubit.dart';
import 'package:task_management/cubit/user/user_states.dart';

import '../../components/components.dart';
import '../../components/screen_size.dart';
import '../../constants/constants.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context,state) {
        UserCubit cubit = UserCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.createUserFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add New User!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.04,
                      ),
                      Text(
                        'Create a new user now and assign them tasks right away.',
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
                        label: 'Name',
                        controller: cubit.userNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter user name';
                          }
                          if (value.length < 3) {
                            return 'user name must be at least 3 characters';
                          }
                          if (value.length > 20) {
                            return 'user name must be at most 20 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.02,
                      ),
                      TextFieldComponent(
                        label: 'Email',
                        controller: cubit.userEmailController,
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
                        label: 'Phone',
                        controller: cubit.userPhoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter phone';
                          }
                          if (value.length > 11) {
                            return 'The phone must be between 0 and 11 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.02,
                      ),
                      TextFieldComponent(
                        label: 'Password',
                        controller: cubit.userPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter password';
                          }
                          if (value.length < 6) {
                            return 'password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.02,
                      ),
                      CupertinoSegmentedControl(
                        children: cubit.userTypes,
                        groupValue: cubit.userType,
                        onValueChanged:(value){
                          cubit.changeType(value);
                        },
                        selectedColor: defaultColor,
                        borderColor: defaultColor,
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.02,
                      ),
                      defaultButton(
                          text: 'CREATE',
                          onpressed: () {
                            if (cubit.createUserFormKey.currentState!.validate()) {
                              cubit.createUser(context);
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
