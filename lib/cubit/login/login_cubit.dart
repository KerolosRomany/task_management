import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../screens/home_screens/home_screen.dart';
import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Login
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    LoginCubit cubit = LoginCubit.get(context);
    String email = cubit.loginEmailController.text;
    String password = cubit.loginPasswordController.text;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 202 || response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        authToken = jsonResponse['data']['token'];
        print(authToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        loginEmailController.clear();
        loginPasswordController.clear();
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('This account doesn\'t exist'),
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
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  bool keepLogedInChecked = false;

  // This function is called when the checkbox is checked or unchecked.
  void handleCheckboxChanged(bool value) {
    keepLogedInChecked = value;
      emit(ChangeCheckboxState());
  }

}
