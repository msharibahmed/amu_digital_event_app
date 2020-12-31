import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/event_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List<dynamic>> events = {
    DateTime.now(): [Text('hello')],
    DateTime.parse("2020-12-12 20:18:04Z"): [1, 2]
  };
  Map<DateTime, List<dynamic>> holidays = {
    DateTime.now(): [Text('hello'), 2, 3],
    DateTime.parse("2020-12-12 20:18:04Z"): [1, 2]
  };

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        // direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 30, bottom: 10),
            child: Text(
              '   AMU Digital Events',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableCalendar(
                      availableGestures: AvailableGestures.horizontalSwipe,
                      holidays: holidays,
                      events: events,
                      calendarController: _calendarController,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: mq.height * 0.454,minHeight: mq.height*0.2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink[50],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 10),
                                    child: Text(
                                      'Upcoming Events',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: mq.height * 0.387,minHeight: mq.height*0.1),
                                    // maxHeight: mq.height * 0.2,
                                    // maxHeight: mq.height * 0.38785,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          EventCard(index: index),
                                      itemCount: 100,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
