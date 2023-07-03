import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_project/models/employees_model.dart';

@immutable
abstract class EmployeesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class EmployeesLoadedEvent extends EmployeesEvent {
  @override
  List<Object> get props => [];
}

@immutable
class EmployeesAddedEvent extends EmployeesEvent {
  final EmployeeModel employee;

  EmployeesAddedEvent({required this.employee});

  @override
  List<Object> get props => [employee];
}

@immutable
class EmployeesUpdateEvent extends EmployeesEvent {
  final int employeeId;
  final EmployeeModel employee;

  EmployeesUpdateEvent({required this.employeeId, required this.employee});

  @override
  List<Object> get props => [employeeId, employee];
}

@immutable
class EmployeeDeleteEvent extends EmployeesEvent {
  final int employeeId;

  EmployeeDeleteEvent({required this.employeeId});

  @override
  List<Object> get props => [employeeId];
}
