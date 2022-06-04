class SensorModel {
  int id;
  String name, dataDesc;

  SensorModel.fromJson(parsedJson)
      : id = parsedJson['id'] ?? -99999,
        name = parsedJson['name'] ?? "NO sensor name FROM API",
        dataDesc = parsedJson['data_desc'] ?? "NO sensor data_desc FROM API";

  static List<SensorModel> list(List input) {
    List<SensorModel> output = [];
    for (Map<String, dynamic> item in input) {
      output.add(SensorModel.fromJson(item));
    }

    return output;
  }

  @override
  String toString() {
    return "($id, $name, $dataDesc)";
  }
}
