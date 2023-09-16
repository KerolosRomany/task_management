import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/constants/constants.dart';
import 'package:task_management/screens/login_screen.dart';

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
              authToken = '';
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }, child: Text('Logout',style: TextStyle(
              fontSize: 20,
            ),))
          ],
        ),
      ),
    );
  }
}
