import 'dart:convert' show json;

import 'address_model.dart';

enum UserRole {
  ROLE_PATIENT,
  ROLE_DOCTOR,
  ROLE_ADMIN,
  ROLE_CG,
}

List<UserRole> _getRoles(roles) {
  List<UserRole> list = [];
  for (final item in roles) {
    list.add(UserRole.values
        .firstWhere((e) => e.toString() == 'UserRole.' + item['name']));
  }
  return list;
}

class UserModel {
  String firstName, lastName, email, password, phoneNo, cnic;
  // DateTime dob;
  List<UserRole> roles;
  AddressModel address;
  int id, age;
  UserModel? cgUser;

  UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNo,
    this.cnic,
    // this.dob,
    this.address,
    this.id,
    this.age,
    this.roles,
  );

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'] ?? "NO NAME FROM API",
        lastName = parsedJson['lastName'] ?? "NO NAME FROM API",
        email = parsedJson['email'] ?? "NO EMAIL FROM API",
        password = parsedJson['password'] ?? "NO PASSWORD FROM API",
        phoneNo = parsedJson['phone_no'] ?? "NO PHONENO FROM API",
        cnic = parsedJson['cnic'] ?? "NO CNIC FROM API",
        address = AddressModel.fromJson(parsedJson['address']),
        id = parsedJson['id'] ?? -999,
        age = parsedJson['age'] ?? -9999,
        roles = _getRoles(parsedJson['roles']),
        cgUser = parsedJson['cg_user'] == null
            ? null
            : UserModel.fromJson(parsedJson['cg_user']);

  @override
  String toString() {
    return "$id, $firstName, $lastName, $email, $password, $phoneNo, $cnic, $age, $address, $roles";
  }
}
