import 'package:rxdart/rxdart.dart';
import 'dart:async' show StreamTransformer;

import '../resources/rest_api.dart';
import '../models/notification_model.dart';

class NotificationBloc {
  final _api = RestAPI();
  final _notifications = BehaviorSubject<Future<List<NotificationModel>>>();

  Stream<Future<List<NotificationModel>>> get notificationStream =>
      _notifications;

  void fetchNotifications(String jwt, int patientID) async {
    while (true) {
      _notifications.sink.add(_api.fetchNotifications(jwt, patientID));
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
