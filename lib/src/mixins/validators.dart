import 'dart:async';

class Validator {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError("Enter a valid email");
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 3) {
        sink.add(password);
      } else {
        sink.addError("Password must be 4 or more characters");
      }
    },
  );

  final validateText = StreamTransformer<String, String>.fromHandlers(
    handleData: (text, sink) {
      if (text.length > 0) {
        sink.add(text);
      } else {
        sink.addError("This field cannot be empty");
      }
    },
  );
}
