import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'user_bloc.dart';
import '../resources/rest_api.dart';
import '../mixins/validators.dart';

class LoginBloc with Validator {
  final _api = RestAPI();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<String> get emailStream => _email.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  CombineLatestStream<dynamic, bool> get submitValid =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  void submit(BuildContext context, UserBloc userBloc) async {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print("Off to the API with $validEmail, $validPassword");

    String? jwt = await _api.authenticate(validEmail, validPassword);
    if (jwt == null) {
      Fluttertoast.showToast(
        msg: "Email/password is incorrect. Try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    userBloc.setJWT = jwt;
    userBloc.setEmail = validEmail;
    Navigator.pushNamed(context, "/dashboard");
  }
}
