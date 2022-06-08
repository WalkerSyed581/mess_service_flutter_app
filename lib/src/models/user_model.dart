import 'dart:convert' show json;

import 'address_model.dart';
import 'department_model.dart';

enum Designation {
  STAFF,
  STUDENT,
  TEACHER,
}

class AdminModel{
  String firstName, lastName;

  AdminModel(this.firstName, this.lastName);

  @override
  String toString() {
    return 'AdminModel{firstName: $firstName, lastName: $lastName}';
  }

  AdminModel.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'] ?? "NO NAME FROM API",
        lastName = parsedJson['lastName'] ?? "NO NAME FROM API";


}

Designation _getDesignation(designation) {
  return  Designation.values.firstWhere((e) => e.toString() == 'Designation.' + designation);;
}

class UserModel {
  String firstName, lastName, email, password, phoneNo;
  int id;
  // DateTime dob;
  Designation designation;
  DepartmentModel dept;

  UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.id,
    this.phoneNo,
    this.designation,
    this.dept
  );

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'] ?? "NO NAME FROM API",
        lastName = parsedJson['lastName'] ?? "NO NAME FROM API",
        email = parsedJson['email'] ?? "NO EMAIL FROM API",
        password = parsedJson['password'] ?? "NO PASSWORD FROM API",
        phoneNo = parsedJson['phone_no'] ?? "NO PHONENO FROM API",
        id = parsedJson['id'] ?? -999,
        designation = _getDesignation(parsedJson['roles']),
        dept = DepartmentModel.fromJson(parsedJson['dept']);

  @override
  String toString() {
    return "$id, $firstName, $lastName, $email, $password, $phoneNo";
  }
}
