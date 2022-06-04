import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/sensor_bloc.dart';
import '../blocs/user_bloc.dart';

import '../models/sensor_model.dart';
import '../models/user_model.dart';

import '../widgets/dashboard/sensors_loading/sensors_loading.dart';
import '../widgets/sensors/sensors.dart';
import '../widgets/misc/new_assessment.dart';

class PatientDisplayScreen extends StatelessWidget {
  UserModel patient;

  PatientDisplayScreen(this.patient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.firstName} ${patient.lastName}'),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: SingleChildScrollView(
        child: sensors(context),
      ),
    );
  }

  Widget sensors(BuildContext context) {
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);

    return Column(
      children: [
        StreamBuilder(
          stream: sensorBloc.sensorsStream,
          builder: (BuildContext context,
              AsyncSnapshot<Future<List<SensorModel>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("LOADING USER"),
              );
            }
            return FutureBuilder(
              future: snapshot.data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<SensorModel>> sensorsSnapshot) {
                if (!sensorsSnapshot.hasData) {
                  return DashboardSensorsLoading();
                }
                return DashboardSensors(sensorsSnapshot.data!);
              },
            );
          },
        ),
        const SizedBox(height: 5),
        NewAssessment(patient.id),
        const SizedBox(height: 5),
        ElevatedButton(
          child: const Text("View past assessments"),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/assessments',
              arguments: {
                "patientID": patient.id,
                "doctorID": Provider.of<UserBloc>(context, listen: false).id,
              },
            );
          },
        ),
      ],
    );
  }
}
