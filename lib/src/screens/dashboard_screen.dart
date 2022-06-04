import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/user_bloc.dart';
import '../blocs/notification_bloc.dart';

import '../widgets/dashboard/sensors_tab.dart';
import '../widgets/dashboard/doctors_tab.dart';
import '../widgets/misc/submit_button.dart';
// import '../widgets/dashboard/refresh.dart';

// import '../blocs/sensor_bloc.dart';
// import '../blocs/user_bloc.dart';

import '../models/user_model.dart';
import '../models/notification_model.dart';
// import '../models/sensor_model.dart';

import '../widgets/dashboard/profile/profile_widget.dart';
// import '../widgets/sensors/sensors.dart';
import '../widgets/dashboard/profile_loading/profile_loading.dart';
// import '../widgets/dashboard/sensors_loading/sensors_loading.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    UserBloc userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: .1,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: getDrawer(userBloc, context),
      body: StreamBuilder(
        stream: userBloc.userStream,
        builder:
            (BuildContext context, AsyncSnapshot<Future<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("LOADING USER"),
            );
          }
          return FutureBuilder(
            future: snapshot.data,
            builder:
                (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
              List<Widget> children = <Widget>[];

              if (!userSnapshot.hasData) {
                children.add(loadingProfile());
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[loadingProfile()],
                  padding: const EdgeInsets.all(10),
                );
              } else {
                userBloc.id = userSnapshot.data!.id;
                UserModel user = userSnapshot.data!;
                userBloc.user = user;

                // PATIENT
                if (user.roles[0] == UserRole.ROLE_PATIENT) {
                  userBloc.patientID = userBloc.id;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: patientDashboard(user, context),
                        ),
                      ),
                    ),
                  );
                }

                // ADMIN
                else if (user.roles[0] == UserRole.ROLE_ADMIN) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flex(direction: Axis.horizontal),
                      SizedBox(
                        width: 325,
                        child: SubmitButton(
                          text: "Sign up new user",
                          iconData: Icons.outbox,
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   width: 325,
                      //   child: SubmitButton(
                      //     text: "Register new device",
                      //     iconData: Icons.app_registration_rounded,
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, '/signup');
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                }

                // CAREGIVER
                else if (user.roles[0] == UserRole.ROLE_CG) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flex(direction: Axis.horizontal),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Welcome, ${user.firstName} ${user.lastName}\nYour patient's details are below:",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        caregiverDashboard(user.cgUser!, context, userBloc),
                      ],
                    ),
                  );
                }

                // DOCTOR
                else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flex(direction: Axis.horizontal),
                      profile(user),
                      const SizedBox(height: 5),
                      doctorDashboard(user, context, userBloc)
                    ],
                  );
                }
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> patientDashboard(UserModel user, BuildContext context) {
    final notifBloc = Provider.of<NotificationBloc>(context);
    notifBloc.fetchNotifications(Provider.of<UserBloc>(context).jwt, user.id);
    return <Widget>[
      Flex(direction: Axis.horizontal),
      profile(user),
      DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: StreamBuilder(
                stream: notifBloc.notificationStream,
                builder: (BuildContext context,
                    AsyncSnapshot<Future<List<NotificationModel>>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No notifications..."),
                    );
                  } else {
                    return FutureBuilder(
                      future: snapshot.data,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<NotificationModel>?>
                              notifSnapshot) {
                        if (!notifSnapshot.hasData) {
                          return const Center(
                            child: Text("No notifications..."),
                          );
                        } else {
                          List<NotificationModel> notifs = notifSnapshot.data!;
                          print(notifs);
                          return Container(
                            color: Colors.grey[300],
                            // height: 200,
                            width: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: notifs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(notifs[index].content),
                                  subtitle: Text(notifs[index].title),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  }
                  // return FutureBuilder(
                  //   future: snapshot.data,
                },
              ),
            ),
            Container(
              height: 60,
              color: Theme.of(context).primaryColor,
              child: const TabBar(
                tabs: [
                  Tab(
                    text: "Sensors",
                    icon: Icon(Icons.sensors_sharp),
                  ),
                  Tab(
                    text: 'Doctors',
                    icon: Icon(Icons.health_and_safety),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: TabBarView(
                children: [
                  SensorsTab(),
                  DoctorsTab(user.id),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget caregiverDashboard(
      UserModel patient, BuildContext context, UserBloc userBloc) {
    // userBloc.fetchCgUser()
    userBloc.patientID = patient.id;
    return Container(
      alignment: Alignment.topCenter,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: patientDashboard(patient, context),
      ),
    );
  }

  Widget doctorDashboard(
      UserModel user, BuildContext context, UserBloc userBloc) {
    userBloc.fetchPatients(1);

    return StreamBuilder(
      stream: userBloc.patientsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Future<List<UserModel>?>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (BuildContext context,
              AsyncSnapshot<List<UserModel>?> patientsSnapshot) {
            if (!patientsSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<UserModel> patients = patientsSnapshot.data!;
              return SizedBox(
                width: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: patients.length,
                    itemBuilder: (context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                                '${patients[index].firstName} ${patients[index].lastName}'),
                            subtitle: Text("Age: ${patients[index].age}"),
                            onTap: () {
                              userBloc.patientID = patients[index].id;

                              Navigator.pushNamed(
                                context,
                                '/patientdata',
                                arguments: {"patient": patients[index]},
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                    padding: const EdgeInsets.all(10)),
              );
            }
          },
        );
      },
    );
    // return <Widget>[
    //   profile(user),
    //   sensors(context),
    // ];
  }

  Widget profile(UserModel user) {
    return ProfileWidget(user);
  }

  Widget loadingProfile() {
    return Shimmer(
      child: ProfileWidgetLoading(),
      gradient: LinearGradient(colors: <Color>[
        Colors.grey[300]!,
        Colors.grey[50]!,
      ]),
      period: const Duration(seconds: 1),
    );
  }

  // Widget adminDashboard(UserBloc userBloc) {
  //   return Circ
  // }

  Drawer getDrawer(UserBloc userBloc, BuildContext context) {
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: const Text(
                "About",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
        ],
        padding: const EdgeInsets.all(5),
      ),
    );
    // UserModel userModel = userBloc.userStream.value;
    /*return Drawer(
      child: StreamBuilder(
        stream: userBloc.userStream,
        builder:
            (BuildContext context, AsyncSnapshot<Future<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("LOADING USER"),
            );
          }
          return FutureBuilder(
            future: snapshot.data,
            builder:
                (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
              List<Widget> children = <Widget>[
                const DrawerHeader(child: Text("Hi")),
              ];

              if (userSnapshot.hasData) {
                // userBloc.id = userSnapshot.data!.id;
                for (UserRole role in userSnapshot.data!.roles) {
                  children.add(Text(role.toString()));
                }
              }
              // children.add(sensors(context));

              return ListView(
                scrollDirection: Axis.vertical,
                children: children,
                padding: const EdgeInsets.all(5),
              );
            },
          );
        },
      ),
    );*/
  }
}
