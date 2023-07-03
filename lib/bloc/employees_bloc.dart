import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/bloc/employees_event.dart';
import 'package:task_project/bloc/employees_state.dart';
import 'package:task_project/core/init/employees_database_provider.dart';
import 'package:task_project/models/employees_model.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc() : super(EmployeesInitial()) {
    on<EmployeesLoadedEvent>(_employeesLoaded);
    on<EmployeesAddedEvent>(_employeesAdded);
    on<EmployeesUpdateEvent>(_employeesUpdated);
    on<EmployeeDeleteEvent>(_employeesDeleted);
  }
  EmployeddDatabaseProvide employeddDatabaseProvide =
      EmployeddDatabaseProvide();
  void _employeesLoaded(
      EmployeesLoadedEvent event, Emitter<EmployeesState> emit) async {
    await employeddDatabaseProvide.open();
    List<EmployeeModel> employees = await employeddDatabaseProvide.getList();

    emit(EmployeesLoadedState(
      prevemployeesList:
          employees.where((element) => element.endate!.isNotEmpty).toList(),
      curremployeesList: employees
          .where((element) =>
              element.startDate!.isNotEmpty && element.endate!.isEmpty)
          .toList(),
    ));
  }

  void _employeesAdded(
      EmployeesAddedEvent event, Emitter<EmployeesState> emit) async {
    await employeddDatabaseProvide.open();
    await employeddDatabaseProvide.insertItem(event.employee);
    add(EmployeesLoadedEvent());
  }

  void _employeesUpdated(
      EmployeesUpdateEvent event, Emitter<EmployeesState> emit) async {
    await employeddDatabaseProvide.open();
    await employeddDatabaseProvide.updateItem(event.employeeId, event.employee);
    add(EmployeesLoadedEvent());
  }

  void _employeesDeleted(
      EmployeeDeleteEvent event, Emitter<EmployeesState> emit) async {
    await employeddDatabaseProvide.open();
    await employeddDatabaseProvide.removeItem(event.employeeId);
    add(EmployeesLoadedEvent());
  }
}
