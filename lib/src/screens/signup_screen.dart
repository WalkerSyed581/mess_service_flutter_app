import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/signup_bloc.dart';
import '../blocs/user_bloc.dart';

import '../widgets/misc/stream_text_field.dart';

// role
// emergencey_contact
class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupBloc signupBloc = Provider.of<SignupBloc>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: .1,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Image.asset(
              'assets/signup_screen/signup_heart.png',
              height: 35,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            const Text('Sign up'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flex(direction: Axis.horizontal),
              // const SizedBox(height: 20),
              // Image.asset(
              //   'assets/signup_screen/img_placeholder.png',
              //   width: 150,
              // ),
              // const SizedBox(height: 15),
              // const Text("Upload your picture"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "John",
                            labelText: "First name",
                            stream: signupBloc.firstNameStream,
                            onChanged: signupBloc.changeFirstName,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "Doe",
                            labelText: "Last name",
                            stream: signupBloc.lastNameStream,
                            onChanged: signupBloc.changeLastName,
                            textInputType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "Gender",
                            labelText: "Gender",
                            stream: signupBloc.genderStream,
                            onChanged: signupBloc.changeGender,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 30,
                          child: StreamTextField(
                            hintText: "(yyyy-mm-dd)",
                            labelText: "Birthday",
                            stream: signupBloc.dobStream,
                            onChanged: signupBloc.changeDob,
                            // textInputType: TextInputType.number,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "Age",
                            labelText: "Age",
                            stream: signupBloc.ageStream,
                            onChanged: signupBloc.changeAge,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "example@example.com",
                      labelText: "Email",
                      stream: signupBloc.emailStream,
                      onChanged: signupBloc.changeEmail,
                      textInputType: TextInputType.emailAddress,
                    ),
                    // const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "Password",
                      labelText: "Password",
                      stream: signupBloc.passwordStream,
                      onChanged: signupBloc.changePassword,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "1234567",
                            labelText: "Phone No.",
                            stream: signupBloc.phoneNoStream,
                            onChanged: signupBloc.changePhoneNo,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "cnic",
                            labelText: "CNIC",
                            stream: signupBloc.cnicStream,
                            onChanged: signupBloc.changeCnic,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "1234567",
                            labelText: "Emergency",
                            stream: signupBloc.emergencey_contactStream,
                            onChanged: signupBloc.changeEmergencey_contact,
                            // textInputType: TextInputType.text,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "role",
                            labelText: "Role",
                            stream: signupBloc.roleStream,
                            onChanged: signupBloc.changeRole,
                            // textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: StreamTextField(
                            hintText: "City",
                            labelText: "City",
                            stream: signupBloc.cityStream,
                            onChanged: signupBloc.changeCity,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox(width: 5)),
                        Expanded(
                          flex: 10,
                          child: StreamTextField(
                            hintText: "Street No.",
                            labelText: "Street No.",
                            stream: signupBloc.streetStream,
                            onChanged: signupBloc.changeStreet,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: StreamTextField(
                            hintText: "House No.",
                            labelText: "House No.",
                            stream: signupBloc.suiteStream,
                            onChanged: signupBloc.changeSuite,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox(width: 5)),
                        Expanded(
                          flex: 15,
                          child: StreamTextField(
                            hintText: "Zipcode",
                            labelText: "Zipcode",
                            stream: signupBloc.zip_codeStream,
                            onChanged: signupBloc.changeZip_code,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    submitButton(signupBloc, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton(SignupBloc signupBloc, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signupBloc.submit(Provider.of<UserBloc>(context, listen: false).jwt);
      },
      child: const Text(
        'Sign up',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
