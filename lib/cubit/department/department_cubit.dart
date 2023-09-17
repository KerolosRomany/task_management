import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/home_screens/home_screen.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import 'department_states.dart';
import 'package:http/http.dart' as http;

class DepartmentCubit extends Cubit<DepartmentStates> {
  DepartmentCubit() : super(InitialDepartmentState());

  static DepartmentCubit get(context) => BlocProvider.of(context);
  var departmentNameController = TextEditingController();
  var departmentNameUpdatedController = TextEditingController();
  var departmentManagerController = TextEditingController();
  var createDepartmentFormKey = GlobalKey<FormState>();
  var updateDepartmentFormKey = GlobalKey<FormState>();
  late DepartmentModel selectedModel;
  Future<void> createDepartment(BuildContext context) async {

    final url = Uri.parse('$baseUrl/department/store');

    final Map<String, dynamic> data ={
      "name": departmentNameController.text,
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
        print('Department created successfully');
        print('Response: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text("Department is created"),
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

        emit(SuccessfulCreatedDepartmentState());
      }
      else if (response.statusCode == 422){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("The name has already been taken."),
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
        emit(FailCreatedDepartmentState());
      }
      else {
        // Failed to add venue
        print('Failed to add department');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        emit(FailCreatedDepartmentState());
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
  Future<List<DepartmentModel>> getAllDepartments() async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/department/index'),
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
        final departments = results
            .map<DepartmentModel>((json) => DepartmentModel.fromJson(json))
            .toList();
        print ('Hello4' );
        return departments;
      } else {
        throw 'Failed to load departments. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load departments: $e';
    }
  }


  Future<void> updateDepartment(BuildContext context) async {
    final url = Uri.parse('$baseUrl/department/update/${selectedModel.id}');

    final Map<String, dynamic> data ={
      "name": departmentNameUpdatedController.text,
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
        print('Department updated successfully');
        print('Response: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text("Department is updated"),
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

        emit(SuccessfulUpdatedDepartmentState());
      }
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        final managerIdMessage = jsonResponse['data']['manager_id'][0];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(managerIdMessage),
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
        emit(FailUpdatedDepartmentState());
      }
      else {
        // Failed to add venue
        print('Failed to update department');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        emit(FailUpdatedDepartmentState());
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
}