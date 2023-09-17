import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/cubit/user/user_states.dart';
import 'package:task_management/screens/home_screens/home_screen.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import 'package:http/http.dart' as http;

import '../login/login_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPhoneController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userDepartmentController = TextEditingController();
  var createUserFormKey = GlobalKey<FormState>();
  var updateUserFormKey = GlobalKey<FormState>();
  var userNameUpdatedController = TextEditingController();
  var userEmailUpdatedController = TextEditingController();
  var userPhoneUpdatedController = TextEditingController();
  var userPasswordUpdatedController = TextEditingController();
  var userDepartmentUpdatedController = TextEditingController();
  int userType = 2;
  late String userTypeString;
  final Map<int, Widget> userTypes = const <int, Widget>{
    0: Padding(
      padding: EdgeInsets.all(15),
      child: Text('Admin',style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),),
    ),
    1: Padding(
      padding: EdgeInsets.all(15),
      child: Text('Manager',style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),),
    ),
    2: Padding(
      padding: EdgeInsets.all(15),
      child: Text('User',style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),),
    ),
  };
  void changeType(value) {
    userType = value;
    emit(ChangeUserTypeState());
  }
  // Future<void> updateDepartment(BuildContext context) async {
  //   final url = Uri.parse('$baseUrl/department/update/${departmentManagerController.text}');
  //
  //   final Map<String, dynamic> data ={
  //     "name": departmentNameUpdatedController.text,
  //   };
  //
  //
  //   try {
  //     final response = await http.post(url, body: jsonEncode(data),
  //         headers:
  //         {
  //           'Authorization': 'Bearer $authToken',
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //         }
  //     );
  //
  //     print(response.statusCode);
  //     if (response.statusCode == 201) {
  //       print('Department created successfully');
  //       print('Response: ${response.body}');
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Success'),
  //           content: Text("Department is updated"),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'OK',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen())),
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //
  //       emit(SuccessfulUpdatedDepartmentState());
  //     }
  //     else if (response.statusCode == 422){
  //       final jsonResponse = json.decode(response.body);
  //       final managerIdMessage = jsonResponse['data']['manager_id'][0];
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Error'),
  //           content: Text(managerIdMessage),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'OK',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //       emit(FailUpdatedDepartmentState());
  //     }
  //     else {
  //       // Failed to add venue
  //       print('Failed to update department');
  //       print('Status Code: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //       emit(FailUpdatedDepartmentState());
  //     }
  //   } catch (error) {
  //     // Error occurred during the HTTP request
  //     print('Error: $error');
  //   }
  // }
  Future<void> createUser(BuildContext context) async {

    final url = Uri.parse('$baseUrl/user/store');

    final Map<String, dynamic> data ={
      "name": userNameController.text,
      "email": userEmailController.text,
      "phone": userPhoneController.text,
      "password": userPasswordController.text,
      "user_type": userType,
    };


    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('User created successfully');
        print('Response: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text("User is created"),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );

        emit(SuccessfulCreatedUserState());
      }
      else if (response.statusCode == 422){
        print('Response: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(""),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        emit(FailCreatedUserState());
      }
      else {
        // Failed to add venue
        print('Failed to add department');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        emit(FailCreatedUserState());
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
  late UserModel selectedUserModel;
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/index'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },);
      print ('Status code ${response.statusCode}' );
      if (response.statusCode == 200 ) {
        print ('Hello' );
        final decodedBody = json.decode(response.body);
        print ('Hello2' );
        final List<dynamic> results = decodedBody['data'];
        print ('Hello3' );
        final users = results
            .map<UserModel>((json) => UserModel.fromJson(json))
            .toList();
        print ('Hello4' );
        return users;
      } else {
        throw 'Failed to load users. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load users: $e';
    }
  }
  Future<void> updateUser(BuildContext context) async {
    final url = Uri.parse('$baseUrl/user/update/${selectedUserModel.id}');
    if (userType==0){
      userTypeString = 'admin';
    }
    else if (userType==1){
      userTypeString = 'manage';
    }
    else {
      userTypeString = 'employee';
    }
    final Map<String, dynamic> data ={
      "name": userNameUpdatedController.text,
      "email": userEmailUpdatedController.text,
      "phone": userPhoneUpdatedController.text,
      "user_type": userTypeString,
    };


    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );

      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('User updated successfully');
        print('Response: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text("User is updated"),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );

        emit(SuccessfulUpdatedUserState());
      }
      else if (response.statusCode == 422){

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        emit(FailUpdatedUserState());
      }
      else {
        // Failed to add venue
        print('Failed to update user');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        emit(FailUpdatedUserState());
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }

}