import 'package:task_project/core/init/database/database_model.dart';

class EmployeeModel extends DatabaseModel<EmployeeModel> {
  int? id;
  String? employeeName;
  String? role;
  String? startDate;
  String? endate;

  EmployeeModel(
      {this.id, this.employeeName, this.role, this.startDate, this.endate});

  EmployeeModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    employeeName = json['employeeName'] ?? '';
    role = json['role'] ?? '';
    startDate = json['startdate'] ?? '';
    endate = json['enddate'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeName'] = employeeName;
    data['role'] = role;
    data['startdate'] = startDate;
    data['enddate'] = endate;
    return data;
  }

  @override
  EmployeeModel fromJson(Map<String, dynamic> json) {
    return EmployeeModel.fromJson(json);
  }
}
