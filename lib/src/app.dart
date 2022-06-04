import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
      child: Provider<SensorBloc>(
        create: (BuildContext context) => SensorBloc(),
        child: Provider<AssessmentBloc>(
          create: (BuildContext context) => AssessmentBloc(),
          child: Provider<NotificationBloc>(
            create: (BuildContext context) => NotificationBloc(),
            child: MaterialApp(
              title: 'Digicare',
              onGenerateRoute: routes,
              theme: ThemeData(
                primaryColor: const Color.fromRGBO(0, 109, 119, 1.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MaterialPageRoute routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Provider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
            child: LoginScreen(),
          );
        },
      );
    } else if (settings.name == '/dashboard') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
          userBloc.fetchUser(1);
          SensorBloc sensorBloc =
              Provider.of<SensorBloc>(context, listen: false);
          sensorBloc.fetchSensors(userBloc.jwt);
          return DashboardScreen();
        },
      );
    } else if (settings.name == '/add_doctors') {
      final Map<String, dynamic> rcvdData =
          settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDoctorScreen(rcvdData['patientID']);
        },
      );
    } else if (settings.name == '/assessments') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final Map<String, dynamic> rcvdData =
              settings.arguments as Map<String, dynamic>;
          Provider.of<AssessmentBloc>(context, listen: false)
              .fetchPastAssessments(
            [
              Provider.of<UserBloc>(context, listen: false).jwt,
              rcvdData["doctorID"],
              rcvdData["patientID"],
            ],
          );
          return PastAssessmentsScreen();
        },
      );
    } else if (settings.name == '/signup') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Provider<SignupBloc>(
            create: (BuildContext context) => SignupBloc(),
            child: SignupScreen(),
          );
        },
      );
    } else if (settings.name!.substring(0, 11).compareTo('/sensordata') == 0) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
          SensorBloc sensorBloc =
              Provider.of<SensorBloc>(context, listen: false);
          print(settings.name!.substring(12));
          sensorBloc.fetchReadings(
            <String, dynamic>{
              'jwt': userBloc.jwt,
              'patientID': userBloc.patientID,
              'sensorID': int.parse(settings.name!.substring(12)),
            },
          );

          return SensorDisplayScreen();
        },
      );
    } else {
      // "/patientdata"
      final Map<String, dynamic> rcvdData =
          settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return PatientDisplayScreen(rcvdData['patient']);
        },
      );
    }
  }
}
