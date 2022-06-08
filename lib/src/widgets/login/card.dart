import 'package:flutter/material.dart';
import 'package:mess_service/src/widgets/form_field_widget.dart';
import 'package:provider/provider.dart';

import '../../validation/login_form_provider.dart';

import '../misc/stream_text_field.dart';
import '../misc/submit_button.dart';

class LoginCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  int _index = 0;
  final _formKey = GlobalKey<FormState>();
  late FormProvider _formProvider;

  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    return IndexedStack(
      index: _index,
      children: <Widget>[
        loginCard(context),
        signupCard(context),
      ],
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          "Login",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        imageField(
          Icons.person,
          CustomFormField(
            hintText: 'you@example.com',
            onChanged: _formProvider.validateEmail,
            errorText: _formProvider.email.error,
          ),
        ),
        imageField(
          Icons.lock_outlined,
          CustomFormField(
            hintText: 'Password',
            onChanged: _formProvider.validatePassword,
            errorText: _formProvider.password.error,
          ),
        ),
        Consumer<FormProvider>(
            builder: (context, model, child) {
              return ElevatedButton(
                onPressed: () {
                  if (model.validate) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SuccessPage(),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              );
            }
        ),
        const SizedBox(height: 10),
        Text(
          "Forgot password?",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        // Row(
        //   children: const [
        //     Expanded(child: Divider()),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 10),
        //       child: Text('OR'),
        //     ),
        //     Expanded(child: Divider()),
        //   ],
        // ),
        // const SizedBox(height: 10),
        // indexButton("Sign up", Icons.arrow_forward),
      ],
    );
  }

  Widget imageField(IconData icon, Widget field) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color.fromARGB(255, 97, 175, 182),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: field),
        ],
      ),
    );
  }


  Widget indexButton(String text, IconData iconData) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _index = _index == 0 ? 1 : 0;
                });
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(49)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Icon(
                    iconData,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget signupCard(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/signup_screen/signup_heart.png',
          width: 50,
        ),
        Text(
          "Sign up as",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        SubmitButton(
          text: "Doctor",
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          iconData: Icons.health_and_safety,
        ),
        const SizedBox(height: 20),
        SubmitButton(
          text: "Patient",
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          iconData: Icons.masks,
        ),
        const SizedBox(height: 20),
        SubmitButton(
          text: "Caregiver",
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          iconData: Icons.health_and_safety,
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('OR'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 2),
        indexButton("Log in", Icons.arrow_back),
      ],
    );
  }
}
