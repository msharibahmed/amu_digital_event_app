import 'dart:ui';

import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/bottom_sheet/bottom_sheet.dart';
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
    Provider.of<Https>(context, listen: false).getEvents();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List<dynamic>> events = {
    DateTime.parse("2020-12-11 20:18:04Z"): [1, 3,4,5,6,7,8,9],
    DateTime.now(): [Text('hello')],
  };
  Map<DateTime, List<dynamic>> holidays = {
    DateTime.now(): [Text('hello'), 2, 3,4,5,6,7,8,9],
    DateTime.parse("2020-12-12 20:18:04Z"): [1, 2]
  };
  var calendarSize = {
    CalendarFormat.month: 'Compact',
    CalendarFormat.week: 'Full Stretched'
  };
  TabBar _tabBar = TabBar(tabs: [
    Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        'Upcoming',
        style: TextStyle(color: Colors.black),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        'Ongoing',
        style: TextStyle(color: Colors.black),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        'Happened',
        style: TextStyle(color: Colors.black),
      ),
    ),
  ]);
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
                          showBarModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EventBottomSheet(selectedDate: selectedDate));
                        },
                        initialCalendarFormat: CalendarFormat.month,
                        formatAnimation: FormatAnimation.scale,
                        availableCalendarFormats: calendarSize,
                        availableGestures: AvailableGestures.all,
                        calendarController: _calendarController,
                        events: events,
                        holidays: holidays,
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
                              child: DefaultTabController(
                                child: Scaffold(
                                  backgroundColor: Colors.indigo[100],
                                  appBar: AppBar(
                                      centerTitle: false,
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          'Events',
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      ),
                                      backgroundColor: Colors.indigo[200],
                                      bottom: PreferredSize(
                                        child: _tabBar,
                                        preferredSize: Size.fromHeight(
                                          _tabBar.preferredSize.height - 50,
                                        ),
                                      )),
                                  body: TabBarView(children: [
                                    UpComingEvents(mq: mq),
                                    OngoingEvents(mq: mq),
                                    HappenedEvents(mq: mq),
                                  ]),
                                ),
                                length: 3,
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

class UpComingEvents extends StatelessWidget {
  const UpComingEvents({
    @required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return data.upcomingEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('No Upcoming Events!'),
                Image.network(
                  'https://www.clubr.in/images/no-events-1.png',
                  fit: BoxFit.contain,
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemBuilder: (context, index) => EventCard(
                index: index,
                data: data.upcomingEventList,
              ),
              itemCount: data.upcomingEventList.length,
            ),
          );
  }
}

class HappenedEvents extends StatelessWidget {
  const HappenedEvents({
    @required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return data.happenedEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('No Happened Events!'),
                Image.network(
                  'https://www.clubr.in/images/no-events-1.png',
                  fit: BoxFit.contain,
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemBuilder: (context, index) => EventCard(
                index: index,
                data: data.happenedEventList,
              ),
              itemCount: data.happenedEventList.length,
            ),
          );
  }
}

class OngoingEvents extends StatelessWidget {
  const OngoingEvents({
    @required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return data.ongoingEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('No Ongoing Events!'),
                Image.network(
                  'https://www.clubr.in/images/no-events-1.png',
                  fit: BoxFit.contain,
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemBuilder: (context, index) => EventCard(
                index: index,
                data: data.ongoingEventList,
              ),
              itemCount: data.ongoingEventList.length,
            ),
          );
  }
}
