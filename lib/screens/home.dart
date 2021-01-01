import 'package:amui_digital_event_app/widgets/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/event_card.dart';

class Home extends StatefulWidget {
  static const routeName = 'home-screen';
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
  var calendarSize = {
    CalendarFormat.month: 'Compact',
    CalendarFormat.week: 'Full Stretched'
  };

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: SingleChildScrollView(
        child: Column(
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
                        onDaySelected: (selectedDate, __, ___) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => EventBottomSheet());
                        },
                        initialCalendarFormat: CalendarFormat.month,
                        formatAnimation: FormatAnimation.scale,
                        availableCalendarFormats: calendarSize,
                        availableGestures: AvailableGestures.all,
                        calendarController: _calendarController,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: mq.height * 0.72,
                            minHeight: mq.height * 0.2),
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
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'Upcoming Events',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      endIndent: mq.width * 0.54,
                                      indent: mq.width * 0.05,
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: mq.height * 0.6291,
                                          minHeight: mq.height * 0.1),
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
      ),
    );
  }
}
