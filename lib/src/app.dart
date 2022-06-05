import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:flutter/material.dart';
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
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
          highlightColor: Colors.deepPurple,
        ),
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }

  // MaterialPageRoute routes(RouteSettings settings) {
  //   if (settings.name == '/') {
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return Provider<LoginBloc>(
  //           create: (BuildContext context) => LoginBloc(),
  //           child: LoginScreen(),
  //         );
  //       },
  //     );
  //   } else if (settings.name == '/dashboard') {
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
  //         userBloc.fetchUser(1);
  //         SensorBloc sensorBloc =
  //         Provider.of<SensorBloc>(context, listen: false);
  //         sensorBloc.fetchSensors(userBloc.jwt);
  //         return DashboardScreen();
  //       },
  //     );
  //   } else if (settings.name == '/add_doctors') {
  //     final Map<String, dynamic> rcvdData =
  //     settings.arguments as Map<String, dynamic>;
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return AddDoctorScreen(rcvdData['patientID']);
  //       },
  //     );
  //   } else if (settings.name == '/assessments') {
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         final Map<String, dynamic> rcvdData =
  //         settings.arguments as Map<String, dynamic>;
  //         Provider.of<AssessmentBloc>(context, listen: false)
  //             .fetchPastAssessments(
  //           [
  //             Provider.of<UserBloc>(context, listen: false).jwt,
  //             rcvdData["doctorID"],
  //             rcvdData["patientID"],
  //           ],
  //         );
  //         return PastAssessmentsScreen();
  //       },
  //     );
  //   } else if (settings.name == '/signup') {
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return Provider<SignupBloc>(
  //           create: (BuildContext context) => SignupBloc(),
  //           child: SignupScreen(),
  //         );
  //       },
  //     );
  //   } else if (settings.name!.substring(0, 11).compareTo('/sensordata') == 0) {
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
  //         SensorBloc sensorBloc =
  //         Provider.of<SensorBloc>(context, listen: false);
  //         print(settings.name!.substring(12));
  //         sensorBloc.fetchReadings(
  //           <String, dynamic>{
  //             'jwt': userBloc.jwt,
  //             'patientID': userBloc.patientID,
  //             'sensorID': int.parse(settings.name!.substring(12)),
  //           },
  //         );
  //
  //         return SensorDisplayScreen();
  //       },
  //     );
  //   } else {
  //     // "/patientdata"
  //     final Map<String, dynamic> rcvdData =
  //     settings.arguments as Map<String, dynamic>;
  //     return MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return PatientDisplayScreen(rcvdData['patient']);
  //       },
  //     );
  //   }
  // }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'October 30'),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
        ],
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> verifyEmail(
      String email,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      var methods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

