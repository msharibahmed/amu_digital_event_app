import 'package:flutter/foundation.dart';

class EventModel {
  String id;
  String name;
  String description;
  String url;
  String department;
  String faculty;
  DateTime startDate;
  DateTime endDate;
  bool online;
  EventModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.url,
    @required this.department,
    @required this.faculty,
    @required this.startDate,
    @required this.endDate,
    @required this.online,
  });
}
