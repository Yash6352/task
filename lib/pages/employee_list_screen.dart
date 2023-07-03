import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_project/bloc/employees_bloc.dart';
import 'package:task_project/bloc/employees_event.dart';
import 'package:task_project/bloc/employees_state.dart';
import 'package:task_project/models/employees_model.dart';
import 'package:task_project/utils/colorutils.dart';
import 'package:task_project/utils/constants.dart';
import 'package:task_project/utils/font_utils.dart';
import 'package:task_project/utils/variable_utils.dart';

import 'add_emplyee/add_employee_details_screen.dart';

class EmptyEmployeeListScreen extends StatefulWidget {
  const EmptyEmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmptyEmployeeListScreen> createState() =>
      _EmptyEmployeeListScreenState();
}

class _EmptyEmployeeListScreenState extends State<EmptyEmployeeListScreen> {
  late EmployeesBloc employeesBloc;
  @override
  void initState() {
    employeesBloc = BlocProvider.of(context);
    employeesBloc.add(EmployeesLoadedEvent());
    super.initState();
  }

  void checkValidation(
      String content, bool iscurremp, EmployeeModel employee, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(content),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            BlocProvider.of<EmployeesBloc>(context).add(
              EmployeesAddedEvent(employee: employee),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        // Customize your AppBar here
        title: Text(
          VariableUtils.emplyoee,
          style:
              FontUtils.medium.copyWith(fontSize: 15, color: ColorUtils.white),
        ),
        backgroundColor: ColorUtils.blueF2,
        elevation: 0,
        // Add any additional properties you need
      ),
      body: BlocBuilder<EmployeesBloc, EmployeesState>(
        bloc: employeesBloc,
        builder: (context, state) {
          if (state is EmployeesLoadedState) {
            return state.curremployeesList!.isEmpty &&
                    state.prevemployeesList!.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      '${kimagePath}empty_employee.svg',
                      alignment: Alignment.center,
                    ),
                  )
                : Column(
                    children: [
                      if (state.curremployeesList!.isNotEmpty)
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: ColorUtils.whiteF2),
                          child: Text(
                            VariableUtils.currentemployees,
                            style: TextStyle(
                                color: ColorUtils.blueF2,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                      if (state.curremployeesList!.isNotEmpty)
                        Flexible(
                          child: ListView.builder(
                            itemCount: state.curremployeesList!.length,
                            itemBuilder: (ctx, i) => Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (e) {
                                checkValidation(
                                  VariableUtils.employeedatahasbeendeleted,
                                  true,
                                  state.curremployeesList![i],
                                  i,
                                );
                                BlocProvider.of<EmployeesBloc>(context).add(
                                  EmployeeDeleteEvent(
                                    employeeId: state.curremployeesList![i].id!,
                                  ),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      "${kimagePath}delete.png",
                                      scale: 4,
                                    )
                                  ],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: EmployeeWidget(
                                  ename: state
                                          .curremployeesList![i].employeeName ??
                                      '',
                                  erole: state.curremployeesList![i].role ?? '',
                                  startDate:
                                      state.curremployeesList![i].startDate ??
                                          '',
                                  endDate:
                                      state.curremployeesList![i].endate ?? '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (state.prevemployeesList!.isNotEmpty)
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: ColorUtils.whiteF2),
                          child: Text(
                            VariableUtils.previousemployees,
                            style: TextStyle(
                                color: ColorUtils.blueF2,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                      if (state.prevemployeesList!.isNotEmpty)
                        Flexible(
                          child: ListView.builder(
                            itemCount: state.prevemployeesList!.length,
                            itemBuilder: (ctx, i) => Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (e) {
                                checkValidation(
                                  VariableUtils.employeedatahasbeendeleted,
                                  true,
                                  state.prevemployeesList![i],
                                  i,
                                );
                                BlocProvider.of<EmployeesBloc>(context).add(
                                  EmployeeDeleteEvent(
                                    employeeId: state.prevemployeesList![i].id!,
                                  ),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      "${kimagePath}delete.png",
                                      scale: 4,
                                    )
                                  ],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: EmployeeWidget(
                                  ename: state
                                          .prevemployeesList![i].employeeName ??
                                      '',
                                  erole: state.prevemployeesList![i].role ?? '',
                                  startDate:
                                      state.prevemployeesList![i].startDate ??
                                          '',
                                  endDate:
                                      state.prevemployeesList![i].endate ?? '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: ColorUtils.whiteF2),
                        child: Text(
                          "Swipe left to delete",
                          style: TextStyle(
                            color: ColorUtils.white9E,
                          ),
                        ),
                      )
                    ],
                  );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => const AddEmployeeDetailsScreen(),
            ),
          );
        },
        child: SvgPicture.asset('${kimagePath}add.svg'),
      ),
    );
  }
}

class EmployeeWidget extends StatelessWidget {
  final String ename;
  final String erole;
  final String startDate;
  final String endDate;
  const EmployeeWidget({
    super.key,
    required this.ename,
    required this.erole,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ename,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          erole,
          style: TextStyle(
            fontSize: 12,
            color: ColorUtils.white9E,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (endDate.isEmpty)
          Text(
            "From $startDate",
            style: TextStyle(
              fontSize: 12,
              color: ColorUtils.white9E,
            ),
          ),
        if (endDate.isNotEmpty)
          Text(
            "$startDate - $endDate",
            style: TextStyle(
              fontSize: 12,
              color: ColorUtils.white9E,
            ),
          ),
      ],
    );
  }
}
