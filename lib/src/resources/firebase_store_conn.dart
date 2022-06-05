import 'dart:convert' show json;
import 'package:http/http.dart';
// import 'package:http/testing.dart';

import '../models/user_model.dart';

class RestAPI {
  final Client client = Client();
  // final String _hostAddress = "http://10.0.2.2:8080";
  // final String _hostAddress = "http://127.0.0.1:8080";
  final String _hostAddress = "https://digicare-rest.herokuapp.com";

  Future<String?> authenticate(String email, String password) async {
    Response response = await client.post(
      Uri.parse("$_hostAddress/authenticate"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: '{"email": "$email","password": "$password"}',
    );

    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)['token'];
  }

  Future<UserModel> fetchUser(String jwt, String email) async {
    await Future.delayed(const Duration(seconds: 2));
    Response response = await client.get(
      Uri.parse("$_hostAddress/users/email/$email"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print("${response.body} USER API");
    final user = UserModel.fromJson(json.decode(response.body));
    print(user);
    return user;
  }

}
