import 'dart:async' show StreamTransformer;
import 'package:rxdart/rxdart.dart';

import '../models/reading_model.dart';
import '../models/sensor_model.dart';
import '../resources/rest_api.dart';

class SensorBloc {
  final _sensorsFetch = BehaviorSubject<String>();
  late Stream<Future<List<SensorModel>>> _sensors;
  final _api = RestAPI();

  final _readingsFetch = BehaviorSubject<Map<String, dynamic>>();
  late Stream<Future<List<ReadingModel>?>> _readings;
  late SensorModel currentSensor;

  SensorBloc() {
    print("SENSORBLOC INIT");
    _sensors = _sensorsFetch.stream.transform(_sensorsTransformer());
    _readings = _readingsFetch.stream.transform(_readingsTransformer());
  }

  // getters to streams
  Stream<Future<List<SensorModel>>> get sensorsStream => _sensors;
  Stream<Future<List<ReadingModel>?>> get readingsStream => _readings;

  // getters to sinks
  void Function(String) get fetchSensors => _sensorsFetch.sink.add;
  void Function(Map<String, dynamic>) get fetchReadings =>
      _readingsFetch.sink.add;

  StreamTransformer<String, Future<List<SensorModel>>> _sensorsTransformer() {
    return StreamTransformer<String, Future<List<SensorModel>>>.fromHandlers(
      handleData: (String jwt, sink) {
        print("IN SENSORTRANSFORMER");
        final sensors = _api.fetchAllSensors(jwt);
        sink.add(sensors);
      },
    );
  }

  StreamTransformer<Map<String, dynamic>, Future<List<ReadingModel>?>>
      _readingsTransformer() {
    return StreamTransformer<Map<String, dynamic>,
        Future<List<ReadingModel>?>>.fromHandlers(
      handleData: (Map<String, dynamic> map, sink) {
        print("IN READINGTRANSFORMER");
        final readings = _api.fetchSensorReadings(
            map['jwt'], map['patientID'], map['sensorID']);
        if (readings == null) {
          sink.addError("No readings");
        } else {
          sink.add(readings);
        }
      },
    );
  }
}
