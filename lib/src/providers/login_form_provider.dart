import 'package:flutter/material.dart';

import '../models/validation_model.dart';



class FormProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);

  ValidationModel get email => _email;
  ValidationModel get password => _password;


  void validateEmail(String? val) {
    if (val != null && val.isValidEmail()) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please Enter a Valid Email');
    }
    notifyListeners();
  }
  void validatePassword(String? val) {
    if (val != null && val.isValidPassword()) {
      _password = ValidationModel(val, null);
    } else {
      _password = ValidationModel(null,
          'Password must contain an uppercase, lowercase, numeric digit and special character');
    }
    notifyListeners();
  }

  bool get validate {
    return _email.value != null &&
        _password.value != null
  }
}