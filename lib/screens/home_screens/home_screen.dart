import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/constants/constants.dart';
import 'package:task_management/screens/department_screens/create_department_screen.dart';
import 'package:task_management/screens/department_screens/get_all_departments.dart';
import 'package:task_management/screens/login_screen.dart';

import '../department_screens/update_department_screen.dart';
import '../user_screens/create_user_screen.dart';
import '../user_screens/get_users_screen.dart';
import '../user_screens/update_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisplayDepartmentsScreen()),
              );
            }, child: Text('Departments',style: TextStyle(
              fontSize: 20,
            ),)),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateDepartmentScreen()),
              );
            }, child: Text('Create department',style: TextStyle(
              fontSize: 20,
            ),)),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetUsersScreen()),
              );
            }, child: Text('Users',style: TextStyle(
              fontSize: 20,
            ),)),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateUserScreen()),
              );
            }, child: Text('Create user',style: TextStyle(
              fontSize: 20,
            ),)),
            TextButton(onPressed: (){
              authToken = '';
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }, child: Text('Logout',style: TextStyle(
              fontSize: 20,
            ),)),
          ],
        ),
      ),
    );
  }
}
