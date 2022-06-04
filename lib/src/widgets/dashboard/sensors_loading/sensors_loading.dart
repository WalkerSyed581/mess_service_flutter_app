import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../sensors_loading/sensor_item_loading.dart';

final _gradient = LinearGradient(colors: <Color>[
  Colors.grey[300]!,
  Colors.grey[50]!,
]);

class DashboardSensorsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(3.0),
        children: <Widget>[
          Shimmer(child: SensorItemLoading(), gradient: _gradient),
          Shimmer(child: SensorItemLoading(), gradient: _gradient),
          Shimmer(child: SensorItemLoading(), gradient: _gradient),
          Shimmer(child: SensorItemLoading(), gradient: _gradient),
        ],
      ),
    );
  }
}
