import 'package:flutter/foundation.dart';

class EntranceModel {
  final String id;
  final String name;
  final String course;
  final DateTime date;
  final String url;

  EntranceModel(
      {@required this.id,
      @required this.course,
      @required this.date,
      @required this.url,
      @required this.name});
}
