import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/sensor_bloc.dart';

import '../../models/sensor_model.dart';

import '../../widgets/sensors/sensors.dart';
import '../../widgets/dashboard/sensors_loading/sensors_loading.dart';

class SensorsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SensorsTabState();
  }
}

class SensorsTabState extends State<SensorsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);

    return StreamBuilder(
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
              return loadingSensors();
            }
            return DashboardSensors(sensorsSnapshot.data!);
          },
        );
      },
    );
  }

  Widget loadingSensors() {
    return DashboardSensorsLoading();
  }

  @override
  bool get wantKeepAlive => true;
}
