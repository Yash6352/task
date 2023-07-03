import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_project/models/employees_model.dart';

@immutable
class EmployeesState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmployeesInitial extends EmployeesState {
  @override
  List<Object> get props => [];
}

@immutable
class EmployeesLoadedState extends EmployeesState {
  final List<EmployeeModel>? curremployeesList;
  final List<EmployeeModel>? prevemployeesList;

  EmployeesLoadedState({this.curremployeesList, this.prevemployeesList});

  @override
  List<Object> get props => [curremployeesList!, prevemployeesList!];
}
