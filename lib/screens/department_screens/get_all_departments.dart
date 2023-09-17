
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/constants/constants.dart';
import 'package:task_management/cubit/department/department_cubit.dart';
import 'package:task_management/cubit/department/department_states.dart';
import 'package:task_management/screens/department_screens/create_department_screen.dart';
import 'package:task_management/screens/login_screen.dart';

import '../../components/components.dart';
import '../../components/screen_size.dart';
import '../../models/models.dart';
import '../department_screens/update_department_screen.dart';
import '../user_screens/create_user_screen.dart';
import '../user_screens/update_user_screen.dart';

class DisplayDepartmentsScreen extends StatelessWidget {
  const DisplayDepartmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<DepartmentCubit,DepartmentStates>(
      builder: (context,state){
        DepartmentCubit cubit = DepartmentCubit.get(context);
        return  Scaffold(

          body: FutureBuilder<List<DepartmentModel>>(
            future: cubit.getAllDepartments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              else {
                final venues = snapshot.data;
                if (venues != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Text(
                              'Departments',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: ScreenSize.screenHeight*0.95,
                              child: ListView.separated(
                                  scrollDirection:
                                  Axis.vertical,
                                  shrinkWrap: true,

                                  itemBuilder:
                                      (context, index) =>
                                      buildDepartmentModel(
                                          venues[index],
                                          cubit,
                                          context),
                                  separatorBuilder:
                                      (context, index) =>
                                      Column(
                                        children: [
                                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                                          Divider(height: 1,color: Colors.grey[400]),
                                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                                        ],
                                      ),
                                  itemCount: venues.length),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Placeholder widget if venues is null
                }
              }
            },
          )
        );
      },
    );
  }
  Widget buildDepartmentModel(DepartmentModel model, DepartmentCubit cubit, context) =>
      Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w700,
                ),)
              ],
            ),
            Spacer(),
            defaultTextButton(
              color: Colors.blue,
              text: 'update',
              onpressed: () {
                cubit.selectedModel = model;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateDepartmentScreen()),
                );
              },
              textFontSize: 18,
            )
          ],
        ),
      );

}



