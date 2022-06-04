import 'dart:async' show StreamTransformer;
import 'package:rxdart/rxdart.dart';

import '../mixins/validators.dart';
import '../resources/rest_api.dart';
import '../models/assessment_model.dart';

class AssessmentBloc with Validator {
  final _api = RestAPI();

  // NEW ASSESSMENT STREAMS
  final _notes = BehaviorSubject<String>();
  final _condition = BehaviorSubject<String>();
  final _recommendations = BehaviorSubject<String>();
  final _cgInstr = BehaviorSubject<String>();
  final _dataDesc = BehaviorSubject<String>();

  Function(String) get changeNotes => _notes.sink.add;
  Function(String) get changeCondition => _condition.sink.add;
  Function(String) get changeRecommendations => _recommendations.sink.add;
  Function(String) get changeCgInstr => _cgInstr.sink.add;
  Function(String) get changeDataDesc => _dataDesc.sink.add;

  Stream<String> get notesStream => _notes.stream.transform(validateText);
  Stream<String> get conditionStream =>
      _condition.stream.transform(validateText);
  Stream<String> get recommendationsStream =>
      _recommendations.stream.transform(validateText);
  Stream<String> get cgInstrStream => _cgInstr.stream.transform(validateText);
  Stream<String> get dataDescStream => _dataDesc.stream.transform(validateText);

  CombineLatestStream<dynamic, bool> get submitValid =>
      CombineLatestStream.combine5(
        notesStream,
        conditionStream,
        recommendationsStream,
        cgInstrStream,
        dataDescStream,
        (n, c, r, cg, d) => true,
      );

  // PAST ASSESSMENTS STREAMS
  final _assessmentsFetch = BehaviorSubject<List<dynamic>>();
  late Stream<Future<List<AssessmentModel>?>> _assessments;
  Stream<Future<List<AssessmentModel>?>> get assessmentsStream => _assessments;
  void Function(List<dynamic>) get fetchPastAssessments =>
      _assessmentsFetch.sink.add;

  AssessmentBloc() {
    print("ASSESSMENT BLOC INIT");
    _assessments =
        _assessmentsFetch.stream.transform(_assessmentsTransformer());
  }

  Future<void> submit(String jwt, int patientID) async {
    print("Uploading assessment..");
    await _api.uploadAssessment(
      jwt,
      AssessmentModel(
        -1,
        _notes.value,
        _condition.value,
        _recommendations.value,
        _cgInstr.value,
        _dataDesc.value,
        patientID,
        DateTime.now(),
      ),
    );
  }

  StreamTransformer<List<dynamic>, Future<List<AssessmentModel>?>>
      _assessmentsTransformer() {
    return StreamTransformer<List<dynamic>,
        Future<List<AssessmentModel>?>>.fromHandlers(
      // info contains [jwt, doctorID, patientID]
      handleData: (List<dynamic> info, sink) {
        print("IN PAST ASSESSMENTS TRANSFORMER");
        final _pastAssessments = _api.fetchPastAssessments(info);
        if (_pastAssessments == null) {
          sink.addError("No assessments found");
        } else {
          sink.add(_pastAssessments);
        }
      },
    );
  }
}
