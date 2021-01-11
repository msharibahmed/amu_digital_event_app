import 'package:flutter/foundation.dart';

class ExamModel {
  final String id;
  final String name;
  final String faculty;
  final String department;
  final String course;
  final DateTime date;
  final String courseCode;

  ExamModel(
      {@required this.id,
      @required this.course,
      @required this.courseCode,
      @required this.date,
      @required this.department,
      @required this.faculty,
      @required this.name});
}
