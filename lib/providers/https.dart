import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

class Https with ChangeNotifier {
  List<EventModel> _eventsList = [];
  List<EventModel> get upcomingEventList {
    List<EventModel> tempList = [];
    _eventsList.forEach((element) {if(element.startDate.isAfter(DateTime.now())){
      tempList.add(element);
    }});
    return [...tempList];
  }

  List<EventModel> get ongoingEventList {
    List<EventModel> tempList = [];
_eventsList.forEach((element) {if (element.startDate.isBefore(DateTime.now()) &&
          element.endDate.isAfter(DateTime.now())) {
      tempList.add(element);
      } });
   

    return [...tempList];
  }

  List<EventModel> get happenedEventList {
    List<EventModel> tempList = [];
    _eventsList.forEach((element) {if(element.startDate.isBefore(DateTime.now())){
      tempList.add(element);
    }});return [...tempList];
  }

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
}
