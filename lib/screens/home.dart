import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/bottom_sheet/bottom_sheet.dart';
import '../widgets/event_tabs.dart/happened_events.dart';
import '../widgets/event_tabs.dart/ongoing_events.dart';
import '../widgets/event_tabs.dart/upcoming_events.dart';

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

    // Provider.of<Https>(context, listen: false).getEvents();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

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
    final events = Provider.of<Https>(context, listen: false).eventsCalendarMarker;
    // print(events);

    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:const EdgeInsets.only(left: 16, top: 30, bottom: 10),
              child:const Text(
                '   AMU Digital Events',
                style:const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            ClipRRect(
              borderRadius:const BorderRadius.only(
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
                        // holidays: holidays,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: mq.height * 0.72,
                            minHeight: mq.height * 0.2),
                        child: ClipRRect(
                          borderRadius:const BorderRadius.only(
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
                                        child:const Text(
                                          'Events',
                                          style:const TextStyle(
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
