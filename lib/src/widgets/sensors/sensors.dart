import 'package:flutter/material.dart';

import '../../models/sensor_model.dart';
import 'sensor_item.dart';

class DashboardSensors extends StatelessWidget {
  List<SensorModel> sensors;

  DashboardSensors(this.sensors);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(3.0),
        children: getDashboardItems(context),
      ),
    );
  }

  List<Widget> getDashboardItems(BuildContext context) {
    List<Widget> children = <Widget>[];
    for (SensorModel sensor in sensors) {
      children.add(SensorItem(sensor, Icons.health_and_safety));
    }

    return children;
  }
}
