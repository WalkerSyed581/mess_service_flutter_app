import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/assessment_model.dart';

import '../widgets/misc/stream_text_field.dart';

const _margin = EdgeInsets.all(10);
const _padding = EdgeInsets.all(10);

class _AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _Detail {
  final timestampStream = BehaviorSubject<String>();
  final notesStream = BehaviorSubject<String>();
  final conditionStream = BehaviorSubject<String>();
  final recommendationsStream = BehaviorSubject<String>();
  final cgInstrStream = BehaviorSubject<String>();
  final dataDescStream = BehaviorSubject<String>();

  _Detail(AssessmentModel assessment) {
    timestampStream.sink.add(assessment.timestamp.toString());
    notesStream.sink.add(assessment.notes);
    conditionStream.sink.add(assessment.condition);
    recommendationsStream.sink.add(assessment.recommendations);
    cgInstrStream.sink.add(assessment.cgInstr);
    dataDescStream.sink.add(assessment.dataDesc);
  }
}

class AssessmentDetailScreen extends StatelessWidget {
  final AssessmentModel _assessment;
  late final detail;

  AssessmentDetailScreen(this._assessment) : detail = _Detail(_assessment);

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            StreamTextField(
              hintText: "Notes",
              labelText: "Notes",
              stream: detail.notesStream,
              text: _assessment.notes,
              onChanged: null,
              minLines: 1,
              maxLines: 5,
              margin: _margin,
              padding: _padding,
              decoration: _decoration,
              style: const TextStyle(color: Colors.white),
              focusNode: _AlwaysDisabledFocusNode(),
            ),
            StreamTextField(
              hintText: "Condition",
              labelText: "Condition",
              stream: detail.conditionStream,
              text: _assessment.condition,
              onChanged: null,
              minLines: 1,
              maxLines: 5,
              margin: _margin,
              padding: _padding,
              decoration: _decoration,
              style: const TextStyle(color: Colors.white),
              focusNode: _AlwaysDisabledFocusNode(),
            ),
            StreamTextField(
              hintText: "Recommendations",
              labelText: "Recommendations",
              stream: detail.recommendationsStream,
              text: _assessment.recommendations,
              onChanged: null,
              minLines: 1,
              maxLines: 5,
              margin: _margin,
              padding: _padding,
              decoration: _decoration,
              style: const TextStyle(color: Colors.white),
              focusNode: _AlwaysDisabledFocusNode(),
            ),
            StreamTextField(
              hintText: "CG Instructions",
              labelText: "CG Instructions",
              stream: detail.cgInstrStream,
              text: _assessment.cgInstr,
              onChanged: null,
              minLines: 1,
              maxLines: 5,
              margin: _margin,
              padding: _padding,
              decoration: _decoration,
              style: const TextStyle(color: Colors.white),
              focusNode: _AlwaysDisabledFocusNode(),
            ),
            StreamTextField(
              hintText: "Data description",
              labelText: "Data description",
              stream: detail.dataDescStream,
              text: _assessment.dataDesc,
              onChanged: null,
              minLines: 1,
              maxLines: 5,
              margin: _margin,
              padding: _padding,
              decoration: _decoration,
              style: const TextStyle(color: Colors.white),
              focusNode: _AlwaysDisabledFocusNode(),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoField(String name, String info) {
    return Row(
      children: [
        Text("$name: "),
        const SizedBox(width: 2),
        Text(
          info,
          softWrap: true,
        ),
      ],
    );
  }
}
