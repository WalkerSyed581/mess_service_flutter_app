import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../blocs/login_provider.dart';
import '../blocs/login_bloc.dart';
import '../blocs/user_bloc.dart';

import '../widgets/login/card.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);
    print(MediaQuery.of(context).size);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: .1,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        // child: SingleChildScrollView(
        //   padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset("assets/doctors.png", height: 200),
              // const SizedBox.expand(),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxWidth: 350),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: LoginCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
