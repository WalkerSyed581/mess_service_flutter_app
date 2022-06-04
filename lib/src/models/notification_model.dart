import 'user_model.dart';

class NotificationModel {
  int id;
  String title, content;
  UserModel patient;

  NotificationModel(this.id, this.title, this.content, this.patient);

  NotificationModel.fromJson(parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'],
        patient = UserModel.fromJson(parsedJson['patient']);

  static List<NotificationModel> list(List input) {
    List<NotificationModel> output = [];
    for (Map<String, dynamic> item in input) {
      output.add(NotificationModel.fromJson(item));
    }
    return output;
  }
}
