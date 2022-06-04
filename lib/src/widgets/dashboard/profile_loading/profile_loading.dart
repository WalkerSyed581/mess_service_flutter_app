import 'package:flutter/material.dart';

import 'name_avatar_loading.dart';

// var _montserrat = const TextStyle(
//   fontSize: 12,
//   fontFamily: "Consolas",
// );

class ProfileWidgetLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameAndAvatarLoading(),
            userDetailsLoading(),
            const SizedBox(height: 8),
            // metricsRow(),
            // const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }

  Widget userDetailsLoading() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: rowsLoading(4),
    );
  }

  Widget rowsLoading(int rows) {
    List<Widget> children = <Widget>[];
    for (int i = 0; i < rows; i++) {
      children.add(
        Container(
          height: 10,
          width: 300,
          color: const Color(0xFFEEEEEE),
        ),
      );
      children.add(const SizedBox(height: 2));
    }

    return Column(children: children);
  }

  Widget metricsRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          metric("Subscribers", 6280),
          divider(),
          metric("Followers", 1745),
          divider(),
          metric("Videos", 163),
        ],
      ),
    );
  }

  Widget metric(String metricName, int value) {
    return Column(
      children: [
        Text(
          "$value",
          // style: buildMontserrat(
          //   const Color(0xFF000000),
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        Text(
          metricName,
          // style: buildMontserrat(darkColor),
        )
      ],
    );
  }

  Widget divider() {
    return const SizedBox(
      height: 50,
      child: VerticalDivider(
        color: Color(0xFF9A9A9A),
      ),
    );
  }
}
