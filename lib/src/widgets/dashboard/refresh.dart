import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/user_bloc.dart';
import '../../blocs/sensor_bloc.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({required this.child});

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = Provider.of<UserBloc>(context);
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        userBloc.fetchUser(1);
        sensorBloc.fetchSensors(userBloc.jwt);
      },
    );
  }
}
