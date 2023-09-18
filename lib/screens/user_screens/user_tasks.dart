
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_management/constants/constants.dart';
import 'package:task_management/cubit/department/department_cubit.dart';
import 'package:task_management/cubit/department/department_states.dart';
import 'package:task_management/cubit/user/user_cubit.dart';
import 'package:task_management/cubit/user/user_states.dart';
import 'package:task_management/screens/department_screens/create_department_screen.dart';
import 'package:task_management/screens/login_screen.dart';

import '../../components/components.dart';
import '../../components/screen_size.dart';
import '../../cubit/task/task_cubit.dart';
import '../../cubit/task/task_states.dart';
import '../../models/models.dart';
import '../department_screens/update_department_screen.dart';
import '../user_screens/create_user_screen.dart';
import '../user_screens/update_user_screen.dart';

class UserTasksScreen extends StatefulWidget {
  const UserTasksScreen({Key? key}) : super(key: key);

  @override
  State<UserTasksScreen> createState() => _UserTasksScreenState();
}

class _UserTasksScreenState extends State<UserTasksScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<TaskCubit,TaskStates>(
      builder: (context,state){
        TaskCubit cubit = TaskCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            elevation: 0,
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: defaultColor,)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff091E4A)),),
                Text('11/9/2023',style: TextStyle(fontSize: 18,color: Colors.grey),)
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    CircularPercentIndicator(radius: 25,percent: 0.5,progressColor: Color(0xff94C68D),
                        lineWidth: 7,
                        center: Text( '20/9',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff091E4A),
                            fontSize: 12,

                          ),

                        )),
                    SizedBox(width: ScreenSize.screenWidth * 0.01,),
                    CircularPercentIndicator(radius: 25,percent: 0.7,progressColor: Color(0xffFBA85B),
                        lineWidth: 7,
                        center: Text( '20/6',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff091E4A),
                            fontSize: 12,

                          ),

                        )),
                    SizedBox(width: ScreenSize.screenWidth * 0.01,),
                    CircularPercentIndicator(radius: 25,percent: 0.4,progressColor: Color(0xffF87B7B),
                        lineWidth: 7,
                        center: Text( '20/9',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff091E4A),
                            fontSize: 12,

                          ),

                        )),
                  ],
                ),
              ),

            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: ScreenSize.screenHeight*0.01,),
                CalendarTimeline(
                  showYears: true,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                  onDateSelected: (date) => setState(() => _selectedDate = date),
                  leftMargin: 20,
                  monthColor: Color(0xff091E4A),
                  dayColor: Color(0xff091E4A),
                  dayNameColor: Colors.white,
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: defaultColor,
                  dotsColor: Colors.white,
                  selectableDayPredicate: (date) => date.day != 23,
                  locale: 'en',
                ),
                SizedBox(height: ScreenSize.screenHeight*0.03,),
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildTaskItem(
                            cubit.taskTests[index],
                            cubit,
                            context),
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height:
                          ScreenSize.screenHeight * 0.02,
                        ),
                    itemCount:
                    cubit.taskTests.length),
              ],
            ),
          ),

        );
      },
    );
  }
  Widget buildTaskItem(
      TaskModel model,  cubit, context) =>
      MaterialButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserTasksScreen()));
        },
        child: Container(
          height: ScreenSize.screenHeight * 0.2,
          width: ScreenSize.screenWidth * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
            border: Border.all(
              color: Colors.grey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: defaultColor,fontSize: 25),
                ),
                SizedBox(height: ScreenSize.screenHeight*0.01,),
                Divider(color: Colors.grey,height: 1),
                SizedBox(height: ScreenSize.screenHeight*0.01,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create a High-Intensity Interval...',style: TextStyle(
                        color: Color(0xff091E4A),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis
                    ),),
                    SizedBox(height: ScreenSize.screenHeight*0.025,),
                    Text('Design a 20-minute HIIT workout routine.',style: TextStyle(
                        color: Color(0xff7C808A),
                        overflow: TextOverflow.ellipsis
                    ),)
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time_outlined,color: Colors.grey),
                    SizedBox(width: ScreenSize.screenWidth*0.01,),
                    Text('starts 12/9/2023 - ends 16/9/2023',style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xff091E4A),
                        fontSize: 15
                    ),)
                  ],
                ),

              ],
            ),
          ),
        ),
      );

}



