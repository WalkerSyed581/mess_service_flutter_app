class ReadingModel {
  int id;
  double value;
  DateTime timestamp;

  ReadingModel.fromJson(parsedJson)
      : id = parsedJson["id"],
        value = parsedJson["reading"],
        timestamp = DateTime.tryParse(parsedJson["timestamp"])!;

  static List<ReadingModel> list(List input) {
    List<ReadingModel> output = [];
    for (Map<String, dynamic> item in input) {
      output.add(ReadingModel.fromJson(item));
    }

    return output;
  }

  @override
  String toString() {
    return "($id, $value, $timestamp)";
  }
}
