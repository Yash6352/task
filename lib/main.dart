import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/bloc/employees_bloc.dart';
import 'package:task_project/bloc/employees_event.dart';
import 'package:task_project/pages/employee_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeesBloc()..add(EmployeesLoadedEvent()),
      child: ScreenUtilInit(
        builder: (coxt, c) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Task app',
            home: EmptyEmployeeListScreen(),
          );
        },
      ),
    );
  }
}
