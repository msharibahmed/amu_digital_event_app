import 'package:flutter/foundation.dart';

class NoticeModel {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String url;

  NoticeModel(
      {@required this.id,
      @required this.startDate,
      @required this.endDate,
      @required this.url,
      @required this.name});
}
