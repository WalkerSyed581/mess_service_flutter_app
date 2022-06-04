import 'package:rxdart/rxdart.dart';

import '../mixins/validators.dart';
import '../resources/rest_api.dart';

class SignupBloc with Validator {
  RestAPI _api = RestAPI();

  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  // final _active = BehaviorSubject<boolean>();
  final _username = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();

  final _suite = BehaviorSubject<String>();
  final _street = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  final _zip_code = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _cnic = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _role = BehaviorSubject<String>();
  final _emergencey_contact = BehaviorSubject<String>();

  Function(String) get changeFirstName => _firstName.sink.add;
  Function(String) get changeLastName => _lastName.sink.add;
  // Function(boolean) get change_active => _active.sink.add;
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePhoneNo => _phoneNo.sink.add;

  Function(String) get changeSuite => _suite.sink.add;
  Function(String) get changeStreet => _street.sink.add;
  Function(String) get changeCity => _city.sink.add;
  Function(String) get changeZip_code => _zip_code.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeGender => _gender.sink.add;
  Function(String) get changeCnic => _cnic.sink.add;
  Function(String) get changeAge => _age.sink.add;
  Function(String) get changeRole => _role.sink.add;
  Function(String) get changeEmergencey_contact => _emergencey_contact.sink.add;

  Stream<String> get firstNameStream =>
      _firstName.stream.transform(validateText);
  Stream<String> get lastNameStream => _lastName.stream.transform(validateText);
  Stream<String> get usernameStream => _username.stream.transform(validateText);
  Stream<String> get phoneNoStream => _phoneNo.stream.transform(validateText);

  Stream<String> get emailStream => _email.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  Stream<String> get suiteStream => _suite.stream.transform(validateText);
  Stream<String> get streetStream => _street.stream.transform(validateText);
  Stream<String> get cityStream => _city.stream.transform(validateText);
  Stream<String> get zip_codeStream => _zip_code.stream.transform(validateText);
  Stream<String> get dobStream => _dob.stream.transform(validateText);
  Stream<String> get genderStream => _gender.stream.transform(validateText);
  Stream<String> get cnicStream => _cnic.stream.transform(validateText);
  Stream<String> get ageStream => _age.stream.transform(validateText);
  Stream<String> get roleStream => _role.stream.transform(validateText);
  Stream<String> get emergencey_contactStream =>
      _emergencey_contact.stream.transform(validateText);

  CombineLatestStream<dynamic, bool> get submitValid1 =>
      CombineLatestStream.combine9(
        firstNameStream,
        lastNameStream,
        usernameStream,
        phoneNoStream,
        emailStream,
        passwordStream,
        suiteStream,
        streetStream,
        cityStream,
        (f, l, u, ph, e, p, s, st, c) => true,
      );

  CombineLatestStream<dynamic, bool> get submitValid => CombineLatestStream(
        [
          firstNameStream,
          lastNameStream,
          usernameStream,
          phoneNoStream,
          emailStream,
          passwordStream,
          suiteStream,
          streetStream,
          cityStream,
          zip_codeStream,
          dobStream,
          genderStream,
          cnicStream,
          ageStream,
          roleStream,
          emergencey_contactStream,
        ],
        (values) => values.every((element) => element == true),
      );

  void submit(String jwt) {
    String role(String role) {
      if (role.toLowerCase().compareTo("admin") == 0) {
        return "1";
      } else if (role.toLowerCase().compareTo("patient") == 0) {
        return "2";
      } else if (role.toLowerCase().compareTo("caregiver") == 0) {
        return "3";
      } else {
        return "4";
      }
    }

    //  _firstName.value;
    //  _lastName.value;
    //  _username.value;
    //  _phoneNo.value;
    //  _email.value;
    //  _password.value;
    print('Signed up yay');

    Map<String, dynamic> data = {
      "firstName": _firstName.value,
      "lastName": _lastName.value,
      "email": _email.value,
      "password": _password.value,
      "suite": "House " + _suite.value,
      "street": "Street " + _street.value,
      "city": _city.value,
      "zip_code": _zip_code.value,
      "phone_no": _phoneNo.value,
      "dob": _dob.value,
      "gender": _gender.value.toUpperCase(),
      "cnic": _cnic.value,
      "age": _age.value,
      "role": role(_role.value),
      "emergencey_contact": _emergencey_contact.value,
    };

    _api.signupUser(jwt, data);
  }
}

/*
String firstName
String lastName
boolean active
String username
String email
String password
String phone_no
Date dob
Gender gender
String cnic
int age
String emergencey_contact
User cg_user
String cg_relationship
Role> roles
Address address
*/