// ignore_for_file: non_constant_identifier_names
// ignore_for_file: argument_type_not_assignable

import 'dart:convert';

import 'package:employee_qr/functions/qr/data_models/employee_model.dart';
import 'package:flutter/foundation.dart';

class Department {
  String? department_name;
  List<Employee> employees;
  Department({
    this.department_name,
    required this.employees,
  });

  Department copyWith({
    String? department_name,
    List<Employee>? employees,
  }) {
    return Department(
      department_name: department_name ?? this.department_name,
      employees: employees ?? this.employees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'department_name': department_name,
      'employees': employees.map((x) => x.toMap()).toList(),
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      department_name: map['department_name'],
      employees: List<Employee>.from(
        // ignore: avoid_dynamic_calls
        map['employees']?.map((x) => Employee.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source));

  @override
  String toString() =>
      'Department(department_name: $department_name, employees: $employees)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Department &&
        other.department_name == department_name &&
        listEquals(other.employees, employees);
  }

  @override
  int get hashCode => department_name.hashCode ^ employees.hashCode;
}
