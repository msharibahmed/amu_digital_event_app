import 'package:flutter/foundation.dart';

class HolidayModel {
  String id;
  String name;
  String url;
  DateTime startDate;
  DateTime endDate;
  HolidayModel({
    @required this.id,
    @required this.name,
    @required this.url,
    @required this.startDate,
    @required this.endDate,
  });
}
