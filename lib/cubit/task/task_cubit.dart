import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/cubit/task/task_states.dart';
import 'package:task_management/cubit/user/user_states.dart';
import 'package:task_management/screens/home_screens/home_screen.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import 'package:http/http.dart' as http;

import '../login/login_states.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(InitialTaskState());

  static TaskCubit get(context) => BlocProvider.of(context);
  TaskModel taskTest = TaskModel(
    id: 1,
    name: "Task Test",
    description: "test description",
    photo: "http://127.0.0.1:8000",
    status: "NEW",
    startDate: "2024-01-01",
    endDate: "2024-01-01",
  );
  List<TaskModel> taskTests = [
  TaskModel(
  id: 1,
  name: "Task Test",
  description: "test description",
  photo: "http://127.0.0.1:8000",
  status: "NEW",
  startDate: "2024-01-01",
  endDate: "2024-01-01",
  ),
  TaskModel(
  id: 1,
  name: "Task Test",
  description: "test description",
  photo: "http://127.0.0.1:8000",
  status: "NEW",
  startDate: "2024-01-01",
  endDate: "2024-01-01",
  ),
  TaskModel(
  id: 1,
  name: "Task Test",
  description: "test description",
  photo: "http://127.0.0.1:8000",
  status: "NEW",
  startDate: "2024-01-01",
  endDate: "2024-01-01",
  ),
  TaskModel(
  id: 1,
  name: "Task Test",
  description: "test description",
  photo: "http://127.0.0.1:8000",
  status: "NEW",
  startDate: "2024-01-01",
  endDate: "2024-01-01",
  ),
  ];
}