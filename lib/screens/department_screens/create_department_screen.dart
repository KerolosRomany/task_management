import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/cubit/department/department_cubit.dart';
import 'package:task_management/cubit/department/department_states.dart';

import '../../components/components.dart';
import '../../components/screen_size.dart';

class CreateDepartmentScreen extends StatelessWidget {
  const CreateDepartmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<DepartmentCubit, DepartmentStates>(
      builder: (context,state) {
        DepartmentCubit cubit = DepartmentCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.createDepartmentFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Department!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.screenHeight * 0.04,
                  ),
                  Text(
                    'Create a new department now and assign a manager to start the work!',
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
                    controller: cubit.departmentNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter department name';
                      }
                      if (value.length < 3) {
                        return 'department name must be at least 3 characters';
                      }
                      if (value.length > 20) {
                        return 'department name must be at most 20 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: ScreenSize.screenHeight * 0.03,
                  ),

                  defaultButton(
                      text: 'CREATE',
                      onpressed: () {
                        if (cubit.createDepartmentFormKey.currentState!.validate()) {
                          cubit.createDepartment(context);
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
