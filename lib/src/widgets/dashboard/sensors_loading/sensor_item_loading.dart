import 'package:flutter/material.dart';

class SensorItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration:
          const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: const <Widget>[
            SizedBox(height: 50.0),
            SizedBox(height: 40),
            SizedBox(height: 20.0),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
