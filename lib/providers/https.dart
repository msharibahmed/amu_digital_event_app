import 'dart:convert';
import 'package:amui_digital_event_app/models/notice_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/exam_model.dart';
import '../models/holiday_model.dart';
import '../models/entrance_model.dart';
import '../models/event_model.dart';

class Https with ChangeNotifier {
  //event list

  List<EventModel> _eventsList = [];

  List<EventModel> get eventsList {
    return [..._eventsList];
  }

  //upcoming events
  List<EventModel> get upcomingEventList {
    List<EventModel> tempList = [];
    _eventsList.forEach((element) {
      if (element.startDate.isAfter(DateTime.now())) {
        tempList.add(element);
      }
    });
    return [...tempList];
  }

//ongoing events
  List<EventModel> get ongoingEventList {
    List<EventModel> tempList = [];
    _eventsList.forEach((element) {
      if (element.startDate.isBefore(DateTime.now()) &&
          element.endDate.isAfter(DateTime.now())) {
        tempList.add(element);
      }
    });

    return [...tempList];
  }

//happened events
  List<EventModel> get happenedEventList {
    List<EventModel> tempList = [];
    _eventsList.forEach((element) {
      if (element.endDate.isBefore(DateTime.now())) {
        tempList.add(element);
      }
    });
    return [...tempList];
  }

//holiday list
  List<HolidayModel> _holidayList = [];
  List<HolidayModel> get holidayList {
    return [..._holidayList];
  }

//exam list
  List<ExamModel> _examList = [];
  List<ExamModel> get examList {
    return [..._examList];
  }

  //entrance list
  List<EntranceModel> _entranceList = [];
  List<EntranceModel> get entranceList {
    return [..._entranceList];
  }

  //notice list
  List<NoticeModel> _noticeList = [];
  List<NoticeModel> get noticeList {
    return [..._noticeList];
  }

//event marker on calendar
  Map<DateTime, List<dynamic>> get eventsCalendarMarker {
    Map<DateTime, List<dynamic>> temp = Map();

    for (var i = 0; i < _eventsList.length; i++) {
      temp[_eventsList[i].startDate] = [i];
    }
    return temp;
  }

//holiday marker on calendar
  Map<DateTime, List<dynamic>> get holidaysCalendarMarker {
    Map<DateTime, List<dynamic>> temp = Map();

    for (var i = 0; i < _holidayList.length; i++) {
      temp[_holidayList[i].startDate] = [i];
    }
    return temp;
  }

  List<EventModel> selectedDayEvents(DateTime selectedDate) {
    // print(selectedDate);
    List<EventModel> temp = [];
    _eventsList.forEach((event) {
      var eventDate = event.startDate;
      if (selectedDate.day == eventDate.day &&
          selectedDate.month == eventDate.month &&
          selectedDate.year == eventDate.year) {
        temp.add(event);
      }
    });
    // print(temp);
    return temp;
  }

  List<HolidayModel> selectedDayHoliday(DateTime selectedDate) {
    List<HolidayModel> temp = [];
    _holidayList.forEach((holiday) {
      var holidayDate = holiday.startDate;
      if (selectedDate.day == holidayDate.day &&
          selectedDate.month == holidayDate.month &&
          selectedDate.year == holidayDate.year) {
        temp.add(holiday);
      }
    });
    return temp;
  }

//get all events call method
  Future<void> getEvents() async {
    const url = "https://controllerexams.herokuapp.com/api/v1/calender/events";
    try {
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      // print(resBody);

      List<EventModel> loadedEvents = [];
      resBody.forEach((event) {
        loadedEvents.add(EventModel(
            id: event['id'],
            name: event['name'],
            description: event['description'],
            url: event['url'],
            department: event['department'],
            faculty: event['faculty'],
            startDate: DateTime.parse(event['start_date']),
            endDate: DateTime.parse(event['end_date']),
            online: event['online']));
      });
      _eventsList = loadedEvents;
      print(_eventsList);
    } catch (error) {
      print(error.toString() + 'error in getEvents http call ');
    }
    notifyListeners();
  }

//get all holidays call method
  Future<void> getHolidays() async {
    const url =
        "https://controllerexams.herokuapp.com/api/v1/calender/holidays";
    try {
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      // print(resBody);

      List<HolidayModel> loadedHolidays = [];
      resBody.forEach((holiday) {
        loadedHolidays.add(HolidayModel(
            id: holiday['id'],
            name: holiday['name'],
            startDate: DateTime.parse(holiday['start_date']),
            endDate: DateTime.parse(holiday['end_date']),
            url: holiday['url']));
      });
      _holidayList = loadedHolidays;
      print(_holidayList);
    } catch (error) {
      print(error.toString() + 'error in getHolidays http call ');
    }
    notifyListeners();
  }

//get all exams call method

  Future<void> getExams() async {
    const url = "https://controllerexams.herokuapp.com/api/v1/calender/exams";
    try {
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      // print(resBody);

      List<ExamModel> loadedExams = [];
      resBody.forEach((exam) {
        loadedExams.add(ExamModel(
            id: exam['id'],
            name: exam['name'],
            department: exam['department'],
            faculty: exam['faculty'],
            course: exam['course'],
            courseCode: exam['course_code'],
            date: DateTime.parse(exam['date'])));
      });
      _examList = loadedExams;
      print(_examList);
    } catch (error) {
      print(error.toString() + 'error in getExams http call ');
    }
    notifyListeners();
  }
//get all entrances call method

  Future<void> getEntrances() async {
    const url =
        "https://controllerexams.herokuapp.com/api/v1/calender/entrances";
    try {
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      // print(resBody);

      List<EntranceModel> loadedEntrances = [];
      resBody.forEach((entrance) {
        loadedEntrances.add(EntranceModel(
            id: entrance['id'],
            name: entrance['name'],
            course: entrance['course'],
            url: entrance['url'],
            date: DateTime.parse(entrance['date'])));
      });
      _entranceList = loadedEntrances;
      print(_entranceList);
    } catch (error) {
      print(error.toString() + 'error in getEntrances http call ');
    }
    notifyListeners();
  }
  //get all notices call method

  Future<void> getNotices() async {
    const url =
        "https://controllerexams.herokuapp.com/api/v1/calender/notifications";
    try {
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      // print(resBody);

      List<NoticeModel> loadedNotices = [];
      resBody.forEach((notice) {
        loadedNotices.add(NoticeModel(
            id: notice['id'],
            name: notice['name'],
            url: notice['url'],
            startDate: DateTime.parse(notice['start_date']),
            endDate: DateTime.parse(notice['end_date'])));
      });
      _noticeList = loadedNotices;
      print(_noticeList);
    } catch (error) {
      print(error.toString() + 'error in getNotices http call ');
    }
    notifyListeners();
  }

  var sortEvent = 'All';
  void changeSortEvent(String name, int identifier) {
    sortEvent = name;
    if (identifier == 0) {

    } else if (identifier == 1) {
      // _eventsList.
    } else {}
    notifyListeners();
  }
}
