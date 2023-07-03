import 'package:task_project/core/init/database/database_provider.dart';
import 'package:task_project/models/employees_model.dart';
import 'package:sqflite/sqflite.dart';

class EmployeddDatabaseProvide extends DatabaseProvider<EmployeeModel> {
  final String _employeeDatabaseName = "employeesDatabase";
  final String _employeeTableName = "employees";
  final int _version = 1;
  Database? databases;

  String columnEmployeeName = "employeeName";
  String columnrole = "role";
  String columnStartDate = "startdate";
  String columnEndDate = "enddate";
  String columnId = "id";

  @override
  Future<void> open() async {
    databases = await openDatabase(
      _employeeDatabaseName,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_employeeTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnEmployeeName VARCHAR(255),
        $columnrole VARCHAR(20),
        $columnEndDate VARCHAR(255),
        $columnStartDate VARCHAR(255) )
        ''',
    );
  }

  @override
  Future<List<EmployeeModel>> getList() async {
    open();
    List<Map> employeeMaps = await databases!.query(_employeeTableName);
    return employeeMaps.map((e) => EmployeeModel.fromJson(e)).toList();
  }

  @override
  Future<EmployeeModel> getItem(int id) async {
    open();

    final employeeMaps = await databases!.query(
      _employeeTableName,
      where: '$columnId = ?',
      columns: [columnId],
      whereArgs: [id],
    );

    if (employeeMaps.isNotEmpty) {
      return EmployeeModel.fromJson(employeeMaps.first);
    } else {
      return EmployeeModel();
    }
  }

  @override
  Future<void> close() async {
    await databases!.close();
  }

  @override
  Future<bool> insertItem(EmployeeModel model) async {
    open();

    final employeeMaps = await databases!.insert(
      _employeeTableName,
      model.toJson(),
    );

    return employeeMaps != 0;
  }

  @override
  Future<bool> removeItem(int id) async {
    open();

    final employeeMaps = await databases!.delete(
      _employeeTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return employeeMaps != 0;
  }

  @override
  Future<bool> updateItem(int id, EmployeeModel model) async {
    open();

    final employeeMaps = await databases!.update(
      _employeeTableName,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return employeeMaps != 0;
  }
}
