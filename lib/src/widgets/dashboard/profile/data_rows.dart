import 'package:flutter/material.dart';

class DataRows extends StatelessWidget {
  final List<List<String>> data;
  final double rowSpacing;
  final String delimiter;

  DataRows(this.data, {this.rowSpacing = 2, this.delimiter = ": "});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildColumn(
          List<String>.generate(
            data.length,
            (index) => data[index][0],
            growable: false,
          ),
          alignment: CrossAxisAlignment.end,
        ),
        _buildColumn(
          List<String>.generate(
            data.length,
            (index) => delimiter,
            growable: false,
          ),
        ),
        _buildColumn(
          List<String>.generate(
            data.length,
            (index) => data[index][1],
            growable: false,
          ),
          alignment: CrossAxisAlignment.start,
        ),
      ],
    );
  }

  Widget _buildColumn(List<String> column,
      {CrossAxisAlignment alignment = CrossAxisAlignment.center}) {
    return Column(
      crossAxisAlignment: alignment,
      children: List<Widget>.generate(
        column.length,
        (index) => Text(column[index]),
        growable: false,
      ),
    );
  }
}
