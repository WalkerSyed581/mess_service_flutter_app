import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:flutter/material.dart';
import 'package:mess_service/src/screens/login_screen.dart';
import 'package:mess_service/src/providers/login_form_provider.dart';
import 'package:provider/provider.dart';           // new

import '../firebase_options.dart';                    // new
import 'auth/authentication.dart';                  // new
import 'widgets/misc_widgets.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Meetup',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: routes,
    );
  }

  MaterialPageRoute routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (_) => FormProvider(), child: LoginScreen());
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (_) => FormProvider(), child: LoginScreen());
        },
      );
    }
    // else if (settings.name == '/dashboard') {
    //   return MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    //       userBloc.fetchUser(1);
    //       SensorBloc sensorBloc =
    //       Provider.of<SensorBloc>(context, listen: false);
    //       sensorBloc.fetchSensors(userBloc.jwt);
    //       return DashboardScreen();
    //     },
    //   );
    // }
  }
}


